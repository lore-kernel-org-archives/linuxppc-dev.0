Date: Wed, 19 Jul 2000 09:07:37 -0700
From: Tim Wojtulewicz <Tim.Wojtulewicz@NAU.EDU>
Subject: Panic while building XFree86
To: linuxppc-dev@lists.linuxppc.org
Message-id: <p04301800b59b829649df@[209.147.134.139]>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've been trying to compile XFree86 4.0.1 recently (tried 4 times
already) and my computer keeps throwing kernel panics whenever I do
so.  It usually happens after the compile has been going for a while.
I think it has something to do with the fan coming/not coming on, but
I'm not absolutely sure.  The first three attempts occured using
kernel 2.2.17-pre9-ben1, the fourrth with 2.2.17-pre10-ben2.  Here's
the messages I got from /var/log/messages after the crashes:

Attempt #1:
kernel: NIP: C003D000 XER: 20000000 LR: C003079C REGS: c5ea3d30 TRAP: 0700
kernel: MSR: 00089032 [EEIRDRME]


Attempt #2:
kernel: Unable to handle kernel paging request at virtual address
707d0030 (error 40000000)
kernel: NIP: C003ECA0 XER: 00000000 LR: C00383D4 REGS: c1c9bd20 TRAP: 0300
kernel: MSR: 00009032 [EEIRDRME]
kernel: TASK = c1c9a000[26217] 'make' mm->pgd c3a51000 Last syscall: 106
kernel: last math c1c9a000
kernel: GPR00: 0CD5FA01 C1C9BDD0 C1C9A000 C3B99A60 C1C9BE18 00000001
C1CB5006 7F7F7F7F
kernel: GPR08: 0CD5FA01 0001D008 C1560000 C01D0000 84222448 100365C8
00000001 00000000
kernel: GPR16: 00000000 00000000 00000000 10030000 00009032 01C9BE80
00000000 C0003BA0
kernel: GPR24: C1CB5000 06B7FC83 00000006 C1C9BE18 C157D008 C3B99A60
707D0000 707CFFE8
kernel: Call backtrace:
kernel: C003EA60 C00383D4 C0038790 C00388C4 C0035EE4 C0003928 10014924
kernel: 1000FFE4 1000FDD0 1000EA4C 1000E5B8 1000F618 1000EAD8 1000E5B8
kernel: 1000F618 1000EAD8 1000E5B8 1000E17C 10002538 0FF0B69C 00000000
kernel: Kernel panic: kernel access of bad area pc c003eca0 lr
c00383d4 address 707D0030 tsk make/26217


Attempt #3:
kernel: Unable to handle kernel paging request at virtual address
756965a8 (error 42000000)


Attempt #4:
kernel: NIP: C00BD000 XER: 20000000 LR: C00BCFE4 REGS: c30bbd50 TRAP: 0700
kernel: MSR: 00089032 [EEIRDRME]
kernel: TASK = c30ba000[1099] 'bash' mm->pgd c30bd000 Last syscall: 54
kernel: last math c30ba000
kernel: GPR00: 00000000 C30BBE00 C30BA000 C30BBE08 C30AA124 00000008
C30BBE0C 00000020
kernel: GPR08: 00000001 C0140000 C003B08C C7C2CC00 02000000 100A0400
10030000 10030000
kernel: GPR16: 10030000 7FFFFA38 100A0000 100A0000 00009032 030BBE80
00000000 C0003BBC
kernel: GPR24: C00038D4 C58C0120 C0141B44 C579F900 7FFFF068 C30AA000
C30BBE08 C30AA000
kernel: Call backtrace:
<messages log cut this off>


If anyone has any insight into why this happens, I'd like to know.

Machine specs:
Apple Powerbook G3/500 (Pismo)
128 MB RAM
LinuxPPC 2000

Thanks.

Tim

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
