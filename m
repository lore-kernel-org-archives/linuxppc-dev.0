Return-Path: <skrishnakar@gmail.com>
MIME-Version: 1.0
Date: Tue, 17 Mar 2009 03:25:42 +0530
Message-ID: <6213bc560903161455p2893f021v272d708c8b4479bf@mail.gmail.com>
Subject: Compilation of PREEMPT_RT on PowerPC (ppc440)
From: srikanth krishnakar <skrishnakar@gmail.com>
To: Linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=000e0cd32c220446fc0465438362
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--000e0cd32c220446fc0465438362
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi all,

The latest RT patch "patch-2.6.29-rc6-rt3" is throwing following compilatio=
n
errors for POWERPC  linux kernel 2.6.29-rc6 :-

As I used plain vanilla kernel i.e ->  Linux-2.6.28 + patch-2.6.29-rc6 +
patch-2.6.29-rc6-rt3

While compiling for ppc440...

[root@srikanth linux-2.6.29-rc6]# make ARCH=3Dpowerpc CROSS_COMPILE=3Dppc_4=
40-
zImage
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  SYMLINK include/asm -> include/asm-powerpc
  CC      kernel/bounds.s
  GEN     include/linux/bounds.h
  CC      arch/powerpc/kernel/asm-offsets.s
In file included from include/linux/rwsem.h:37,
                 from include/linux/mm_types.h:11,
                 from include/linux/sched.h:61,
                 from arch/powerpc/kernel/asm-offsets.c:17:
/opt/mlg-rt-test/linux-2.6.29-rc6/arch/powerpc/include/asm/rwsem.h:24:
error: redefinition of =91struct rw_semaphore=92
In file included from
include/linux/rwsem.h:37,

                 from
include/linux/mm_types.h:11,

                 from
include/linux/sched.h:61,

                 from
arch/powerpc/kernel/asm-offsets.c:17:

/opt/mlg-rt-test/linux-2.6.29-rc6/arch/powerpc/include/asm/rwsem.h:46:1:
warning: "__RWSEM_INITIALIZER" redefined
In file included from
include/linux/spinlock.h:118,

                 from
include/linux/seqlock.h:34,

                 from include/linux/time.h:8,
                 from include/linux/timex.h:56,
                 from include/linux/sched.h:54,
                 from arch/powerpc/kernel/asm-offsets.c:17:
include/linux/rt_lock.h:191:1: warning: this is the location of the previou=
s
definition
In file included from include/linux/rwsem.h:37,
                 from include/linux/mm_types.h:11,
                 from include/linux/sched.h:61,
                 from arch/powerpc/kernel/asm-offsets.c:17:
/opt/mlg-rt-test/linux-2.6.29-rc6/arch/powerpc/include/asm/rwsem.h:50:1:
warning: "DECLARE_RWSEM" redefined
In file included from include/linux/spinlock.h:118,
                 from include/linux/seqlock.h:34,
                 from include/linux/time.h:8,
                 from include/linux/timex.h:56,
                 from include/linux/sched.h:54,
                 from arch/powerpc/kernel/asm-offsets.c:17:
include/linux/rt_lock.h:195:1: warning: this is the location of the previou=
s
definition
In file included from include/linux/rwsem.h:37,
                 from include/linux/mm_types.h:11,
                 from include/linux/sched.h:61,
                 from arch/powerpc/kernel/asm-offsets.c:17:
/opt/mlg-rt-test/linux-2.6.29-rc6/arch/powerpc/include/asm/rwsem.h:61:1:
warning: "init_rwsem" redefined
In file included from include/linux/spinlock.h:118,
                 from include/linux/seqlock.h:34,
                 from include/linux/time.h:8,
                 from include/linux/timex.h:56,
                 from include/linux/sched.h:54,
                 from arch/powerpc/kernel/asm-offsets.c:17:
include/linux/rt_lock.h:232:1: warning: this is the location of the previou=
s
definition
/opt/mlg-rt-test/linux-2.6.29-rc6/arch/powerpc/include/asm/rwsem.h:167:
error: expected identifier or =91(=92 before =91{=92 token
make[1]: *** [arch/powerpc/kernel/asm-offsets.s] Error 1
make: *** [prepare0] Error 2
[root@srikanth linux-2.6.29-rc6]#

Has anybody come across this ? If any fixes brought up for build of RT on
PowerPC, pls reply back.


Regards
Srikant
********

--000e0cd32c220446fc0465438362
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: base64

SGkgYWxsLDxicj48YnI+VGhlIGxhdGVzdCBSVCBwYXRjaCAmcXVvdDtwYXRjaC0yLjYuMjktcmM2
LXJ0MyZxdW90OyBpcyB0aHJvd2luZyBmb2xsb3dpbmcgY29tcGlsYXRpb24gZXJyb3JzIGZvciBQ
T1dFUlBDoCBsaW51eCBrZXJuZWwgMi42LjI5LXJjNiA6LTxicj48YnI+QXMgSSB1c2VkIHBsYWlu
IHZhbmlsbGEga2VybmVsIGkuZSAtJmd0O6AgTGludXgtMi42LjI4ICsgcGF0Y2gtMi42LjI5LXJj
NiArIHBhdGNoLTIuNi4yOS1yYzYtcnQzIDxicj4KPGJyPldoaWxlIGNvbXBpbGluZyBmb3IgcHBj
NDQwLi4uPGJyPjxicj5bcm9vdEBzcmlrYW50aCBsaW51eC0yLjYuMjktcmM2XSMgbWFrZSBBUkNI
PXBvd2VycGMgQ1JPU1NfQ09NUElMRT1wcGNfNDQwLSB6SW1hZ2U8YnI+oCBDSEugoKCgIGluY2x1
ZGUvbGludXgvdmVyc2lvbi5ooKCgoKCgoKCgoKAgPGJyPqAgQ0hLoKCgoCBpbmNsdWRlL2xpbnV4
L3V0c3JlbGVhc2UuaKCgoKCgoKCgIDxicj4KoCBTWU1MSU5LIGluY2x1ZGUvYXNtIC0mZ3Q7IGlu
Y2x1ZGUvYXNtLXBvd2VycGMgPGJyPqAgQ0OgoKCgoCBrZXJuZWwvYm91bmRzLnOgoKCgoKCgoKCg
oKCgoKCgoKCgIDxicj6gIEdFTqCgoKAgaW5jbHVkZS9saW51eC9ib3VuZHMuaKCgoKCgoKCgoKCg
oCA8YnI+oCBDQ6CgoKCgIGFyY2gvcG93ZXJwYy9rZXJuZWwvYXNtLW9mZnNldHMuc6AgPGJyPklu
IGZpbGUgaW5jbHVkZWQgZnJvbSBpbmNsdWRlL2xpbnV4L3J3c2VtLmg6MzcsPGJyPgqgoKCgoKCg
oKCgoKCgoKCgIGZyb20gaW5jbHVkZS9saW51eC9tbV90eXBlcy5oOjExLDxicj6goKCgoKCgoKCg
oKCgoKCgIGZyb20gaW5jbHVkZS9saW51eC9zY2hlZC5oOjYxLKCgIDxicj6goKCgoKCgoKCgoKCg
oKCgIGZyb20gYXJjaC9wb3dlcnBjL2tlcm5lbC9hc20tb2Zmc2V0cy5jOjE3Ojxicj4vb3B0L21s
Zy1ydC10ZXN0L2xpbnV4LTIuNi4yOS1yYzYvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL3J3c2Vt
Lmg6MjQ6IGVycm9yOiByZWRlZmluaXRpb24gb2YgkXN0cnVjdCByd19zZW1hcGhvcmWSPGJyPgpJ
biBmaWxlIGluY2x1ZGVkIGZyb20gaW5jbHVkZS9saW51eC9yd3NlbS5oOjM3LKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAg
PGJyPqCgoKCgoKCgoKCgoKCgoKAgZnJvbSBpbmNsdWRlL2xpbnV4L21tX3R5cGVzLmg6MTEsoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoCA8YnI+CqCgoKCgoKCgoKCgoKCgoKAgZnJvbSBpbmNsdWRlL2xpbnV4L3NjaGVkLmg6NjEs
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoCA8YnI+oKCgoKCgoKCgoKCgoKCgoCBmcm9tIGFyY2gvcG93ZXJwYy9rZXJuZWwv
YXNtLW9mZnNldHMuYzoxNzqgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgIDxicj4KL29wdC9tbGctcnQtdGVzdC9saW51eC0yLjYuMjktcmM2L2Fy
Y2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9yd3NlbS5oOjQ2OjE6IHdhcm5pbmc6ICZxdW90O19fUldT
RU1fSU5JVElBTElaRVImcXVvdDsgcmVkZWZpbmVkoCA8YnI+SW4gZmlsZSBpbmNsdWRlZCBmcm9t
IGluY2x1ZGUvbGludXgvc3BpbmxvY2suaDoxMTgsoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxicj4KoKCgoKCgoKCgoKCgoKCg
oCBmcm9tIGluY2x1ZGUvbGludXgvc2VxbG9jay5oOjM0LKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIDxicj6goKCgoKCgoKCg
oKCgoKCgIGZyb20gaW5jbHVkZS9saW51eC90aW1lLmg6OCw8YnI+oKCgoKCgoKCgoKCgoKCgoCBm
cm9tIGluY2x1ZGUvbGludXgvdGltZXguaDo1Niw8YnI+oKCgoKCgoKCgoKCgoKCgoCBmcm9tIGlu
Y2x1ZGUvbGludXgvc2NoZWQuaDo1NCw8YnI+CqCgoKCgoKCgoKCgoKCgoKAgZnJvbSBhcmNoL3Bv
d2VycGMva2VybmVsL2FzbS1vZmZzZXRzLmM6MTc6PGJyPmluY2x1ZGUvbGludXgvcnRfbG9jay5o
OjE5MToxOiB3YXJuaW5nOiB0aGlzIGlzIHRoZSBsb2NhdGlvbiBvZiB0aGUgcHJldmlvdXMgZGVm
aW5pdGlvbjxicj5JbiBmaWxlIGluY2x1ZGVkIGZyb20gaW5jbHVkZS9saW51eC9yd3NlbS5oOjM3
LDxicj6goKCgoKCgoKCgoKCgoKCgIGZyb20gaW5jbHVkZS9saW51eC9tbV90eXBlcy5oOjExLDxi
cj4KoKCgoKCgoKCgoKCgoKCgoCBmcm9tIGluY2x1ZGUvbGludXgvc2NoZWQuaDo2MSw8YnI+oKCg
oKCgoKCgoKCgoKCgoCBmcm9tIGFyY2gvcG93ZXJwYy9rZXJuZWwvYXNtLW9mZnNldHMuYzoxNzo8
YnI+L29wdC9tbGctcnQtdGVzdC9saW51eC0yLjYuMjktcmM2L2FyY2gvcG93ZXJwYy9pbmNsdWRl
L2FzbS9yd3NlbS5oOjUwOjE6IHdhcm5pbmc6ICZxdW90O0RFQ0xBUkVfUldTRU0mcXVvdDsgcmVk
ZWZpbmVkPGJyPgpJbiBmaWxlIGluY2x1ZGVkIGZyb20gaW5jbHVkZS9saW51eC9zcGlubG9jay5o
OjExOCw8YnI+oKCgoKCgoKCgoKCgoKCgoCBmcm9tIGluY2x1ZGUvbGludXgvc2VxbG9jay5oOjM0
LDxicj6goKCgoKCgoKCgoKCgoKCgIGZyb20gaW5jbHVkZS9saW51eC90aW1lLmg6OCw8YnI+oKCg
oKCgoKCgoKCgoKCgoCBmcm9tIGluY2x1ZGUvbGludXgvdGltZXguaDo1Niw8YnI+oKCgoKCgoKCg
oKCgoKCgoCBmcm9tIGluY2x1ZGUvbGludXgvc2NoZWQuaDo1NCw8YnI+CqCgoKCgoKCgoKCgoKCg
oKAgZnJvbSBhcmNoL3Bvd2VycGMva2VybmVsL2FzbS1vZmZzZXRzLmM6MTc6PGJyPmluY2x1ZGUv
bGludXgvcnRfbG9jay5oOjE5NToxOiB3YXJuaW5nOiB0aGlzIGlzIHRoZSBsb2NhdGlvbiBvZiB0
aGUgcHJldmlvdXMgZGVmaW5pdGlvbjxicj5JbiBmaWxlIGluY2x1ZGVkIGZyb20gaW5jbHVkZS9s
aW51eC9yd3NlbS5oOjM3LDxicj6goKCgoKCgoKCgoKCgoKCgIGZyb20gaW5jbHVkZS9saW51eC9t
bV90eXBlcy5oOjExLDxicj4KoKCgoKCgoKCgoKCgoKCgoCBmcm9tIGluY2x1ZGUvbGludXgvc2No
ZWQuaDo2MSw8YnI+oKCgoKCgoKCgoKCgoKCgoCBmcm9tIGFyY2gvcG93ZXJwYy9rZXJuZWwvYXNt
LW9mZnNldHMuYzoxNzo8YnI+L29wdC9tbGctcnQtdGVzdC9saW51eC0yLjYuMjktcmM2L2FyY2gv
cG93ZXJwYy9pbmNsdWRlL2FzbS9yd3NlbS5oOjYxOjE6IHdhcm5pbmc6ICZxdW90O2luaXRfcndz
ZW0mcXVvdDsgcmVkZWZpbmVkPGJyPgpJbiBmaWxlIGluY2x1ZGVkIGZyb20gaW5jbHVkZS9saW51
eC9zcGlubG9jay5oOjExOCw8YnI+oKCgoKCgoKCgoKCgoKCgoCBmcm9tIGluY2x1ZGUvbGludXgv
c2VxbG9jay5oOjM0LDxicj6goKCgoKCgoKCgoKCgoKCgIGZyb20gaW5jbHVkZS9saW51eC90aW1l
Lmg6OCw8YnI+oKCgoKCgoKCgoKCgoKCgoCBmcm9tIGluY2x1ZGUvbGludXgvdGltZXguaDo1Niw8
YnI+oKCgoKCgoKCgoKCgoKCgoCBmcm9tIGluY2x1ZGUvbGludXgvc2NoZWQuaDo1NCw8YnI+CqCg
oKCgoKCgoKCgoKCgoKAgZnJvbSBhcmNoL3Bvd2VycGMva2VybmVsL2FzbS1vZmZzZXRzLmM6MTc6
PGJyPmluY2x1ZGUvbGludXgvcnRfbG9jay5oOjIzMjoxOiB3YXJuaW5nOiB0aGlzIGlzIHRoZSBs
b2NhdGlvbiBvZiB0aGUgcHJldmlvdXMgZGVmaW5pdGlvbjxicj4vb3B0L21sZy1ydC10ZXN0L2xp
bnV4LTIuNi4yOS1yYzYvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL3J3c2VtLmg6MTY3OiBlcnJv
cjogZXhwZWN0ZWQgaWRlbnRpZmllciBvciCRKJIgYmVmb3JlIJF7kiB0b2tlbjxicj4KbWFrZVsx
XTogKioqIFthcmNoL3Bvd2VycGMva2VybmVsL2FzbS1vZmZzZXRzLnNdIEVycm9yIDE8YnI+bWFr
ZTogKioqIFtwcmVwYXJlMF0gRXJyb3IgMjxicj5bcm9vdEBzcmlrYW50aCBsaW51eC0yLjYuMjkt
cmM2XSM8YnI+PGJyIGNsZWFyPSJhbGwiPkhhcyBhbnlib2R5IGNvbWUgYWNyb3NzIHRoaXMgPyBJ
ZiBhbnkgZml4ZXMgYnJvdWdodCB1cCBmb3IgYnVpbGQgb2YgUlQgb24gUG93ZXJQQywgcGxzIHJl
cGx5IGJhY2suIDxicj4KoDxicj48YnI+UmVnYXJkczxicj5TcmlrYW50PGJyPioqKioqKioqPGJy
Pgo=
--000e0cd32c220446fc0465438362--
