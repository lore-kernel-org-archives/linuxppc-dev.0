Return-Path: <skrishnakar@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9CA0CB70BA
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 21 Jul 2009 19:33:49 +1000 (EST)
MIME-Version: 1.0
Date: Tue, 21 Jul 2009 15:03:44 +0530
Message-ID: <6213bc560907210233l17aa3e75pcb7c20e3faa24195@mail.gmail.com>
Subject: msgctl10 fails on Powerpc Linux-2.6.29.6
From: srikanth krishnakar <skrishnakar@gmail.com>
To: Linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=001636e0a82666a8bb046f33f37a
Cc: Ltp-list@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001636e0a82666a8bb046f33f37a
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

The LTP test case *msgctl10.c* fails on linux-2.6.29.6 for PowerPC
architecture (ppc440)


msgctl10    1  B------------[ cut here
]------------

kernel BUG at
arch/powerpc/kernel/traps.c:904!

Oops: Exception in kernel mode, sig: 5
[#9]

PREEMPT LTT NESTING LEVEL :
0

Virtex440

Modules linked
in:

NIP: c038178c LR: c0381640 CTR:
c02650bc

REGS: cafbbe70 TRAP: 0700   Tainted: G      D
(2.6.29.6)

MSR: 00029000 <EE,ME,CE>  CR: 48004224  XER:
20000008

TASK = cafa17f0[6435] 'msgctl10' THREAD:
cafba000

GPR00: 00000001 cafbbf20 cafa17f0 ffffffda 08000000 00000001 00000037
ffffffff
GPR08: cafa17f0 c04a0000 00021002 c0381594 28004222 1001f4bc bf93d950
100b0000
GPR16: 00000007 bf93d95c 100012a0 10005b84 00000067 100174e8 10017500
100174f8
GPR24: 00000000 00000001 103eaa50 00000000 00000000 00000000 08000000
cafbbf50
NIP [c038178c]
program_check_exception+0x1f8/0x5f4

LR [c0381640]
program_check_exception+0xac/0x5f4

Call
Trace:

[cafbbf20] [c0381640] program_check_exception+0xac/0x5f4
(unreliable)
[cafbbf40] [c000e78c]
ret_from_except_full+0x0/0x4c

Instruction
dump:

7d808120 4bc8ac20 2f830001 41beff38 2f83fff2 419e0024 77c00804
4182004c
3d20c04a 8809207c 2f800000 419e0080 <0fe00000> 48000000 80010024
3ca00003
---[ end trace fd0893c7d8cee1bd
]---

ROK  :  Unexpected signal 11
received.

msgctl10    1  FAIL  :  in read # = 21245,key =
533a

msgctl10    0  WARN  :  Verify error in child 13, *buf = f1, val = 6d, size
= 3
msgctl10    1  BROK  :  Unexpected signal 11
received.

msgctl10    1  BROK  :  Msgsnd error in child 14, key =   d344 errno  =
43
msgctl10    0  WARN  :  tst_rmdir(): rmobj(/tmp/msgNjyTEb) failed:
lstat(/tmp/msgNjyTEb) failed; errno=2: No such file or directory
msgctl10    0  WARN  :  tst_rmdir(): rmobj(/tmp/msgNjyTEb) failed:
lstat(/tmp/msgNjyTEb) failed; errno=2: No such file or directory
msgctl10    1  FAIL  :  in read # = 54260,key =
d46d

msgctl10    1  B------------[ cut here ]------------

Any clue ?

Thanks in Advance !
-- 
Srikanth Krishnakar
**********************

--001636e0a82666a8bb046f33f37a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: base64

VGhlIExUUCB0ZXN0IGNhc2UgPGI+bXNnY3RsMTAuYzwvYj4gZmFpbHMgb24gbGludXgtMi42LjI5
LjYgZm9yIFBvd2VyUEMgYXJjaGl0ZWN0dXJlIChwcGM0NDApPGJyPjxicj48YnI+bXNnY3RsMTCg
oKAgMaAgQi0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLaCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoCA8YnI+Cmtlcm5lbCBCVUcgYXQgYXJjaC9wb3dlcnBjL2tlcm5lbC90cmFwcy5jOjkw
NCGgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgPGJyPk9vcHM6IEV4Y2VwdGlvbiBpbiBrZXJu
ZWwgbW9kZSwgc2lnOiA1IFsjOV2goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgPGJyPgpQ
UkVFTVBUIExUVCBORVNUSU5HIExFVkVMIDogMKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgIDxicj5WaXJ0ZXg0NDCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgPGJyPgpNb2R1bGVzIGxpbmtlZCBpbjqgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxicj5O
SVA6IGMwMzgxNzhjIExSOiBjMDM4MTY0MCBDVFI6IGMwMjY1MGJjoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgIDxicj4KUkVHUzogY2FmYmJlNzAgVFJBUDogMDcwMKCgIFRhaW50ZWQ6
IEegoKCgoCBEoKCgoCAoMi42LjI5LjYpoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCA8YnI+TVNSOiAwMDAyOTAwMCAm
bHQ7RUUsTUUsQ0UmZ3Q7oCBDUjogNDgwMDQyMjSgIFhFUjogMjAwMDAwMDigoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoCA8YnI+ClRBU0sgPSBjYWZhMTdmMFs2NDM1XSAmIzM5O21zZ2N0bDEwJiMzOTsgVEhS
RUFEOiBjYWZiYTAwMKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCA8YnI+R1BSMDA6IDAwMDAwMDAx
IGNhZmJiZjIwIGNhZmExN2YwIGZmZmZmZmRhIDA4MDAwMDAwIDAwMDAwMDAxIDAwMDAwMDM3IGZm
ZmZmZmZmoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oCA8YnI+CkdQUjA4OiBjYWZhMTdmMCBjMDRhMDAwMCAwMDAyMTAwMiBjMDM4MTU5NCAyODAwNDIy
MiAxMDAxZjRiYyBiZjkzZDk1MCAxMDBiMDAwMKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgPGJyPkdQUjE2OiAwMDAwMDAwNyBiZjkzZDk1YyAxMDAw
MTJhMCAxMDAwNWI4NCAwMDAwMDA2NyAxMDAxNzRlOCAxMDAxNzUwMCAxMDAxNzRmOKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgPGJyPgpHUFIyNDog
MDAwMDAwMDAgMDAwMDAwMDEgMTAzZWFhNTAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDgw
MDAwMDAgY2FmYmJmNTCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgIDxicj5OSVAgW2MwMzgxNzhjXSBwcm9ncmFtX2NoZWNrX2V4Y2VwdGlvbisweDFm
OC8weDVmNKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxicj4KTFIgW2MwMzgxNjQwXSBwcm9ncmFt
X2NoZWNrX2V4Y2VwdGlvbisweGFjLzB4NWY0oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCA8YnI+
Q2FsbCBUcmFjZTqgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoCA8YnI+CltjYWZiYmYyMF0gW2MwMzgxNjQwXSBwcm9ncmFtX2NoZWNr
X2V4Y2VwdGlvbisweGFjLzB4NWY0ICh1bnJlbGlhYmxlKaCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgPGJyPltjYWZiYmY0MF0gW2Mw
MDBlNzhjXSByZXRfZnJvbV9leGNlcHRfZnVsbCsweDAvMHg0Y6CgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKAgPGJyPgpJbnN0cnVjdGlvbiBkdW1wOqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxicj43ZDgwODEyMCA0YmM4YWMyMCAyZjgzMDAwMSA0
MWJlZmYzOCAyZjgzZmZmMiA0MTllMDAyNCA3N2MwMDgwNCA0MTgyMDA0Y6CgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxicj4KM2QyMGMw
NGEgODgwOTIwN2MgMmY4MDAwMDAgNDE5ZTAwODAgJmx0OzBmZTAwMDAwJmd0OyA0ODAwMDAwMCA4
MDAxMDAyNCAzY2EwMDAwM6CgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoCA8YnI+LS0tWyBlbmQgdHJhY2UgZmQwODkzYzdkOGNlZTFiZCBdLS0t
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCA8YnI+ClJPS6AgOqAgVW5leHBl
Y3RlZCBzaWduYWwgMTEgcmVjZWl2ZWQuoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKAgPGJyPm1zZ2N0bDEwoKCgIDGgIEZBSUygIDqgIGluIHJlYWQgIyA9IDIxMjQ1LGtleSA9oCA1
MzNhoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgPGJyPgptc2djdGwxMKCgoCAwoCBXQVJOoCA6oCBWZXJp
ZnkgZXJyb3IgaW4gY2hpbGQgMTMsICpidWYgPSBmMSwgdmFsID0gNmQsIHNpemUgPSAzoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxicj5tc2djdGwx
MKCgoCAxoCBCUk9LoCA6oCBVbmV4cGVjdGVkIHNpZ25hbCAxMSByZWNlaXZlZC6goKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgIDxicj4KbXNnY3RsMTCgoKAgMaAgQlJPS6AgOqAgTXNnc25kIGVycm9yIGluIGNo
aWxkIDE0LCBrZXkgPaCgIGQzNDQgZXJybm+gID0gNDOgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCA8YnI+bXNnY3RsMTCgoKAgMKAgV0FSTqAg
OqAgdHN0X3JtZGlyKCk6IHJtb2JqKC90bXAvbXNnTmp5VEViKSBmYWlsZWQ6IGxzdGF0KC90bXAv
bXNnTmp5VEViKSBmYWlsZWQ7IGVycm5vPTI6IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3Rvcnk8YnI+
Cm1zZ2N0bDEwoKCgIDCgIFdBUk6gIDqgIHRzdF9ybWRpcigpOiBybW9iaigvdG1wL21zZ05qeVRF
YikgZmFpbGVkOiBsc3RhdCgvdG1wL21zZ05qeVRFYikgZmFpbGVkOyBlcnJubz0yOiBObyBzdWNo
IGZpbGUgb3IgZGlyZWN0b3J5PGJyPm1zZ2N0bDEwoKCgIDGgIEZBSUygIDqgIGluIHJlYWQgIyA9
IDU0MjYwLGtleSA9oCBkNDZkoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgPGJyPgptc2djdGwxMKCgoCAx
oCBCLS0tLS0tLS0tLS0tWyBjdXQgaGVyZSBdLS0tLS0tLS0tLS0toCA8YnI+PGJyPkFueSBjbHVl
ID88YnIgY2xlYXI9ImFsbCI+PGJyPlRoYW5rcyBpbiBBZHZhbmNlICE8YnI+LS0gPGJyPlNyaWth
bnRoIEtyaXNobmFrYXI8YnI+KioqKioqKioqKioqKioqKioqKioqKjxicj4K
--001636e0a82666a8bb046f33f37a--
