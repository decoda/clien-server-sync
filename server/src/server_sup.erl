%%% -------------------------------------------------------------------
%%% Author  : tangj
%%% Description : 服务器监控
%%% 
%%% Created : 2012-11-1
%%% -------------------------------------------------------------------
-module(server_sup).

-behaviour(supervisor).
%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------

%% --------------------------------------------------------------------
%% External exports
%% --------------------------------------------------------------------
-export([]).

%% --------------------------------------------------------------------
%% Internal exports
%% --------------------------------------------------------------------
-export([
		 start_link/0, 
		 start_child/1, 
		 start_child/2, 
		 init/1
  		]).

%% --------------------------------------------------------------------
%% Macros
%% --------------------------------------------------------------------
-define(SERVER, ?MODULE).

%% --------------------------------------------------------------------
%% Records
%% --------------------------------------------------------------------

%% ====================================================================
%% External functions
%% ====================================================================

start_link() ->
	supervisor:start_link({local, ?MODULE}, ?MODULE, []).

start_child(Mod) ->
    start_child(Mod, []).

start_child(Mod, Args) ->
    {ok, _} = supervisor:start_child(?MODULE,
                                     {Mod, 
									  {Mod, start_link, Args},
									  transient, 1000, worker, 
									  [Mod]}),
    ok.

%% ====================================================================
%% Server functions
%% ====================================================================
%% --------------------------------------------------------------------
%% Func: init/1
%% Returns: {ok,  {SupFlags,  [ChildSpec]}} |
%%          ignore                          |
%%          {error, Reason}
%% --------------------------------------------------------------------
init([]) ->
	{ok, {   
		  {one_for_one, 3, 10},   
		  []         
		 }
	}.

%% ====================================================================
%% Internal functions
%% ====================================================================

