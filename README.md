Segfault whenever the dist directory doesn't exist yet. If caching is enabled,
it'll segfault on the first run and sporadically afterward. Caching is disabled
here to make the case easily reproducible.

```bash
rm -rf dist
npx parcel build --no-cache --no-content-hash src/index.html
```

Workaround is to not use threaded workers:

```bash
rm -rf dist
PARCEL_WORKER_BACKEND=process npx parcel build --no-cache --no-content-hash src/index.html
```

Here is the output from segfault-handler:

```
PID 69840 received SIGSEGV for address: 0xb4f8
0   segfault-handler.node               0x00000001035725f8 _ZL16segfault_handleriP9__siginfoPv + 252
1   libsystem_platform.dylib            0x00000001a22144e4 _sigtramp + 56
2   node                                0x000000010129c160 _ZN2v811HandleScopeC1EPNS_7IsolateE + 20
3   node                                0x000000010129c160 _ZN2v811HandleScopeC1EPNS_7IsolateE + 20
4   node.abi102.glibc.node              0x0000000103d70018 _ZN3Nan11AsyncWorker12WorkCompleteEv + 36
5   node.abi102.glibc.node              0x0000000103d70388 _ZN3Nan20AsyncExecuteCompleteEP9uv_work_si + 32
6   libuv.1.dylib                       0x000000010346b8c0 uv__work_done + 192
7   libuv.1.dylib                       0x000000010346ec38 uv__async_io + 320
8   libuv.1.dylib                       0x000000010347e458 uv__io_poll + 1592
9   libuv.1.dylib                       0x000000010346f058 uv_run + 320
10  node                                0x00000001011dd17c _ZN4node6worker16WorkerThreadDataD2Ev + 212
11  node                                0x00000001011dc914 _ZN4node6worker6Worker3RunEv + 1316
12  node                                0x00000001011dedd0 _ZZN4node6worker6Worker11StartThreadERKN2v820FunctionCallbackInfoINS2_5ValueEEEEN3$_38__invokeEPv + 56
13  libsystem_pthread.dylib             0x00000001a21fd240 _pthread_start + 148
14  libsystem_pthread.dylib             0x00000001a21f8024 thread_start + 8
Segmentation fault: 11
```
