From: shuaiye1999@sohu.com
Message-ID: <933899.1058237235238.JavaMail.postfix@mx49.mail.sohu.com>
Date: Tue, 15 Jul 2003 10:47:15 +0800 (CST)
To: "hi" <linuxppc-embedded@lists.linuxppc.org>
Subject: booting succeed,using program fail.
Mime-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi,all:

	I use the ELDK and the kernel source linux-2.4.4 it take,
taking the TQM8260_config as model of our board. the FCC1
as ethernet.use IMMR 0xf0000000.NFS as root file system.

	the linux boot succeed.and  simple program "ls" works well.
but when use some program,it crashed.Can somebody give me some
infomation about it? thx a lot.

ps: first use "find",and "ls", and login
I have a bdi2000 in hand,but not familiar with it.

the output is below:

bash-2.05# find / -name ttt
find / -name ttt
Oops: kernel access of bad area, sig: 11
NIP: C0069488 XER: 20000000 LR: C0065EDC SP: C1959C80 REGS: c1959bd0 TRAP: 0300
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 30E152AC, DSISR: 20000000
TASK = c1958000[226] 'find' Last syscall: 202
last math c1958000 last altivec 00000000
GPR00: 6F616B60 C1959C80 C1958000 C17FE74C C1959CE8 00000000 00000000 00000000
GPR08: 00000001 6F616B5F 0000000D 00000001 64656663 1002EB8C 00000000 100B9210
GPR16: 100D34D0 7FFFFD88 10020000 0000002F 00009032 C1959E38 C00469C4 C1C1DF20
GPR24: C1959E38 C00469C4 C17FE000 00000000 00000072 C1959CE8 C17FE740 C1959CB8
Call backtrace:
C0065F60 C0066488 C00463FC C0046BF8 C0003B7C 1002E728 0FF567D8
10009280 1000229C 10002198 100024F0 10002198 100024F0 10002198
100024F0 10002198 100024F0 10002198 100024F0 10002198 100024F0
10002198 10001E54 10001B38 0FECFF70 00000000
Segmentation fault

bash-2.05# ls
ls
go to the bad_area field....../nOops: kernel access of bad area, sig: 11
NIP: 00000000 XER: 00000000 LR: 00000000 SP: C1959C70 REGS: c1959bc0 TRAP: 0400
MSR: 20009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c1958000[227] 'ls' Last syscall: 90
last math c1958000 last altivec 00000000
GPR00: 00000000 C1959C70 C1958000 00000001 000000BE 00017C05 206C6973 74206465
GPR08: 6C696D69 00000008 C020F060 0000005F 44222082 100B0734 7FFFF5D4 7FFFF5D0
GPR16: 7FFFF5D8 00000000 00000001 0FE8A13C 00009032 01959C80 00000000 C0003DE4
GPR24: C000432C C02D8120 00000000 C1C1DF80 C19F9520 C0192DEC 00000129 C1959C90
Call backtrace:
C0004344 C0003DE4 C00264A0 C002214C C00222CC C000C8F8 C0003DE4
3000996C 30003674 3000DE98 30002364 30002290 300100E8
Segmentation fault

bash-2.05# ls
ls
go to the bad_area field....../nOops: kernel access of bad area, sig: 11
NIP: 00000000 XER: 00000000 LR: 00000000 SP: C19FBCA0 REGS: c19fbbf0 TRAP: 0400
MSR: 20009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c19fa000[198] 'bash' Last syscall: 174
last math 00000000 last altivec 00000000
GPR00: 00000000 C19FBCA0 C19FA000 00000001 000000BE 00017C05 6B6C6F6E 652B7367
GPR08: 727C6174 00000008 000017FC 0000005F 24422080 100B0734 7FFFED88 00000002
GPR16: 7FFFFD90 7FFFFD88 7FFFDD90 10010000 00009032 019FBCB0 00000000 C0003DE4
GPR24: C000432C C19EF2DC 00000000 C19F9F60 0191E183 02000000 C01ECEF0 C19FBCC0
Call backtrace:
C0004344 C0003DE4 C00218C8 C0022328 C000C8F8 C0003DE4 1002CEFC
1001F350 1001EB88 10013564 100111E8 0FE88F70 00000000

scm3 login:

scm3 login: root
rootLast login: Wed Dec 31 19:01:14 on console
go to the bad_area field....../n
scm3 login: root
rootLast login: Wed Dec 31 19:04:31 on console
go to the bad_area field....../n
scm3 login:

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
