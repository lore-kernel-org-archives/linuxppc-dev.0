Subject: FPSCR corruption
From: "McMullan, Jason" <jason.mcmullan@timesys.com>
To: linuxppc-embedded@lists.linuxppc.org
Content-Type: multipart/mixed; boundary="=-5tYPcMBZgFRxlLx/QNDf"
Message-Id: <1087409391.14878.92.camel@veena.timesys>
Mime-Version: 1.0
Date: Wed, 16 Jun 2004 14:09:51 -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--=-5tYPcMBZgFRxlLx/QNDf
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Oddity. I'm seeing SIGFPEs arrive in the wrong process.

I'm seeing this in my 2.4.x kernels, on 8260 and 750 cpus (and anything
else that has an FPU).

Example programs attached. Run 'someFPU' in an xterm. Run 'corruptFPSCR'
in another. Watch 'someFPU' die.

Is this a similar issue to the fast-syscall-return FPU path bug that
troubled the ia64 port?

(and yes, 'corruptFPSCR' is pathological, but so are most
denial-of-service exploits)

--
Jason McMullan <jason.mcmullan@timesys.com>
TimeSys Corporation

--=-5tYPcMBZgFRxlLx/QNDf
Content-Disposition: attachment; filename=someFPU.c
Content-Transfer-Encoding: base64
Content-Type: text/x-c; name=someFPU.c; charset=iso-8859-1

I2luY2x1ZGUgPG1hdGguaD4NCiNpbmNsdWRlIDxzdGRpby5oPg0KI2luY2x1ZGUgPHRpbWUuaD4N
Cg0KaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiBhcmd2W10pDQp7DQoJc3RydWN0IHRpbWVzcGVj
IHNsZWVwdGltZTsNCglzbGVlcHRpbWUudHZfc2VjPTA7DQoJc2xlZXB0aW1lLnR2X25zZWM9NTAw
MDAwOw0KDQoJd2hpbGUoMSkNCgl7DQoJCXBvdygyLjAsIDMuMyk7DQoJCW5hbm9zbGVlcCgmc2xl
ZXB0aW1lLCBOVUxMKTsNCgl9DQoNCglyZXR1cm4gMDsNCn0NCg0KDQoNCg==

--=-5tYPcMBZgFRxlLx/QNDf
Content-Disposition: attachment; filename=corruptFPSCR.c
Content-Transfer-Encoding: base64
Content-Type: text/x-c; name=corruptFPSCR.c; charset=iso-8859-1

I2luY2x1ZGUgPG1hdGguaD4NCiNpbmNsdWRlIDxzdGRpby5oPg0KI2luY2x1ZGUgPHNpZ25hbC5o
Pg0KDQoNCiNkZWZpbmUgZmVzZXRlbnZfcmVnaXN0ZXIoZW52KSBcDQogICAgICAgICh7IGRvdWJs
ZSBkID0gKGVudik7IGFzbSB2b2xhdGlsZSAoIm10ZnNmIDB4ZmYsJTAiIDogOiAiZiIgKGQpKTsg
fSkNCg0KDQp0eXBlZGVmIHVuaW9uDQp7DQogICAgZG91YmxlIGZlbnY7DQogICAgdW5zaWduZWQg
bG9uZyBmcHNjclsyXTsNCn0gbXlfZmVudl91bmlvbl90Ow0KDQp2b2lkIHNpZ2ZwZUhhbmRsZXIo
aW50IHgpDQp7DQoJLy8gRG8gbm90aGluZy4NCgkvLyBUaGUgZXhjZXB0aW9uIHdpbGwgYmUgcmV0
cm93biBmb3JldmVyLi4uDQoJLy8gdW50aWwgaXQgYWZmZWN0cyBhbm90aGVyIHByb2Nlc3MgOy0o
DQp9DQoNCmludCBtYWluICgpDQp7DQoJLy8gUmVnaXN0ZXIgdG8gU0lHRlBFDQoJc2lnbmFsKFNJ
R0ZQRSwgc2lnZnBlSGFuZGxlcik7DQoNCgkvLyBGb3JjZSB0aGUgZ2VuZXJhdGlvbiBvZiBhIFNJ
R0ZQRQ0KCW15X2ZlbnZfdW5pb25fdCBmZW52dDsNCglmZW52dC5mcHNjclsxXSA9IDB4ZmZmZmZm
ZmY7DQoJZmVzZXRlbnZfcmVnaXN0ZXIoZmVudnQuZmVudik7DQoNCglyZXR1cm4gMDsNCn0NCg0K
DQoNCg==

--=-5tYPcMBZgFRxlLx/QNDf--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
