To: =?gb2312?q?Dross=20Zhou?= <zjuzhou@yahoo.com.cn>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Why system panic after sometimes? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 10 May 2002 11:18:54 +0800."
             <20020510031854.87945.qmail@web15005.mail.bjs.yahoo.com>
Date: Fri, 10 May 2002 08:43:29 +0200
Message-Id: <20020510064334.4B2301195B@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20020510031854.87945.qmail@web15005.mail.bjs.yahoo.com> you wrote:
>
> This question has bothered me,I use linux-2.4.4 (
> downloaded from denx.de and porting to our borad
> MPC850+4Mflash+32Mram+USB).We run a server application

Which version of cross tools are you using?

What firmware is used to initialize the board?

Which device drivers are used? USB???

> in borad,but after sometimes such as about a day or
> even several hours ,system will panic. I check our
> program, i think there are no memory leak(or it will
> panic in same time) and other fatal error.
> Here is my dump information:
>
> # Oops: Kernel Mode Software FPU Emulation, sig: 8
> NIP: 00001FFC XER: E0007B7F LR: 0000098C SP: C011AE90
> REGS: c011ade0 TRAP: 1000
> MSR: 00001000 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00
> TASK = c0118fe0[0] 'swapper' Last syscall: 120
> last math 00000000 last altivec 00000000
> GPR00: 00000002 C011AE90 C0118FE0 C011AEA0 0035E000
> C18FDDE8 C0118FE0 00000017
> GPR08: C0124094 000E711D C18FC000 C014B3E0 30026438
> 100195BC 94FF7FD7 B97FDD3E
> GPR16: DBFFE6E5 028002E8 FA200000 FFFFFFF6 00001032
> 0011AE90 C000BEDC 00009032
> GPR24: 00000000 00000001 C18FC000 0020000D C03E2190
> 00002000 C03E2190 C011AF50
> Call backtrace:
> C0003800 00009032 C0003E44 C0003E5C C0128750 C00021E4
> Kernel panic: Attempted to kill the idle task!

Did you ever try to decode this backtrace? What's that C0128750 there?

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Buy land. They've stopped making it."                   - Mark Twain

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
