Message-ID: <3A32D8AE.A04CDFA7@hadess.net>
Date: Sun, 10 Dec 2000 01:13:18 +0000
From: Bastien Nocera <hadess@hadess.net>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Kernel Oops
References: <3A32D416.7D65D47E@hadess.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Bastien Nocera wrote:
>
> Hi,
>
> Just got a kernel Oops:
>
> Dec  9 23:40:59 kara kernel: Linux video capture interface: v1.00
> Dec  9 23:41:02 kara kernel: usb.c: registered new driver ov511
> Dec  9 23:41:02 kara kernel: ov511.c: USB OV511+ camera found
> Dec  9 23:41:02 kara kernel: ov511.c: camera: Creative Labs WebCam 3
> Dec  9 23:41:02 kara kernel: ov511.c: Sensor is an OV7620
> Dec  9 23:41:02 kara kernel: ov511.c: ov511 driver version 1.28
> registered
> Dec  9 23:41:06 kara kernel: Oops: kernel access of bad area, sig: 11
> Dec  9 23:41:06 kara kernel: NIP: C001148C XER: 00000000 LR: C986F41C
> SP: C31B3C90 REGS: c31b3be0 TRAP: 0300
> Dec  9 23:41:06 kara kernel: MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1
> IR/DR: 11
> Dec  9 23:41:06 kara kernel: DAR: 00000000, DSISR: 42000000
> Dec  9 23:41:06 kara kernel: TASK = c31b2000[5102] 'vanity' Last
> syscall: 54
> Dec  9 23:41:06 kara kernel: last math c17f8000 last altivec 00000000
> Dec  9 23:41:06 kara kernel: GPR00: 00000001 C31B3C90 C31B2000 00000024
> C31B3C94 0000001C FFFFFFFC 00000001
> Dec  9 23:41:06 kara kernel: GPR08: 00000078 00000001 000000A0 00000004
> 02000000 1001C6C8 00000000 100C3350
> Dec  9 23:41:06 kara kernel: GPR16: 00000000 7FFFF938 00000000 00000000
> 00009032 031B3E80 00000000 C0004CA4
> Dec  9 23:41:06 kara kernel: GPR24: C00049D4 10003C04 3002676C 00000005
> C31B3C98 403C7601 C4BCA000 00000000
> Dec  9 23:41:06 kara kernel: Call backtrace:
> Dec  9 23:41:06 kara kernel: C3394EC0 C98682E4 C0049A54 C0004A30
> 3000BC54 10003308 10002EC8
> Dec  9 23:41:06 kara kernel: 10001B34 0F76175C 00000000
>
> Given the timings, et all, I guess the ov511 driver gave me this... and
> I can't access the webcam or unload the module. Hope this can help. Oh,
> I'm using kernel-2.4.0-test11 from Paulus' tree.
>
> Cheers

OK, I even found out the code to make it crash. It definitely _is_ the
driver. I stop disturbing you with that and send it to the kernel ML.

Sorry for the bandwidth

--
/Bastien Nocera
http://hadess.net

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
