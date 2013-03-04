#ifndef ByteConverter_h__
#define ByteConverter_h__

#include <algorithm>

#define CLIENT_BIGENDIAN

namespace ByteConverter
{
	template<size_t T>
	inline void convert(char* val)
	{
		std::swap(*val, *(val + T - 1));
		convert < T - 2 > (val + 1);
	}

	template<> inline void convert<0>(char*) {}
	template<> inline void convert<1>(char*) {}             // ignore central byte

	template<typename T>
	inline void apply(T* val)
	{
		convert<sizeof(T)>((char*)(val));
	}
}

#ifdef CLIENT_BIGENDIAN
template<typename T> inline void EndianConvert(T& val) { ByteConverter::apply<T>(&val); }
template<typename T> inline void EndianConvertReverse(T&) { }
#else
template<typename T> inline void EndianConvert(T&) { }
template<typename T> inline void EndianConvertReverse(T& val) { ByteConverter::apply<T>(&val); }
#endif

template<typename T> void EndianConvert(T*);         // will generate link error
template<typename T> void EndianConvertReverse(T*);  // will generate link error

inline void EndianConvert(uint8&) { }
inline void EndianConvert(int8&)  { }
inline void EndianConvertReverse(uint8&) { }
inline void EndianConvertReverse(int8&) { }

#endif // ByteConverter_h__