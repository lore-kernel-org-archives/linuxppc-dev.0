Return-Path: <zengshuai@sogou.com>
Message-ID: <28420291.1133341297330.JavaMail.postfix@mx3.mail.sohu.com>
Date: Wed, 30 Nov 2005 17:01:37 +0800 (CST)
From: <zengshuai@sogou.com>
To: <Linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Subject: Re:linuxppc-embedded help needed:kernel access of bad area
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

detail:
---------------------------------------------------------------------------------
# ls
led-app.exe   led-module.o
# ./led-app.exe
open led-app.exe...OK!
 Oops: kernel access of bad area, sig: 11
NIP: C30B11B4 XER: 00000000 LR: C003A310 SP: C06B1F00 REGS: c06b1e50 TRAP: 0300
   Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 04500000, DSISR: 20000000
TASK = c06b0000[201] 'led-app.exe' Last syscall: 3
last math c06b0000 last altivec 00000000
GPR00: C003A310 C06B1F00 C06B0000 C01A5AA0 7FFFFDE0 00000014 C01A5AC0 00000000
GPR08: 00000000 04500000 0000000C C01A0000 30025CE8 10018B5C 00000000 00000000
GPR16: 00000000 00000000 00000000 00000000 00009032 006B1F40 00000000 C0003E88
GPR24: C0003BE0 00000001 10000500 7FFFFEA4 7FFFFDE0 FFFFFFEA C01A5AA0 00000014
Call backtrace:
10000A1C C003A310 C0003C3C 100004AC 0FEC6D74 00000000
Segmentation fault
#
----------------------------------------------------------------------------------
> -------------------
> From: zengshuai@sogou.com 
> To: ppc 
> Subject: linuxppc-embedded help needed:kernel access of bad area
> Sent: Wed Nov 30 16:18:06 CST 2005
> 
> > i writed a led driver for PQ2FADS(a ppc board).
> > but i can't read/write 0x04500000 where led register addr locate in.
> > i tested two ways to do that.
> > first,
> > p=0x04500000;
> > *p=0x12;
> > ....
> > second,
> > outb(0x12,0x04500000);
> > ...
> > two ways both didn't work.they had a some wrong:kernel access of bad area.
> > how can i know which area is bad area or good area?
> > and what can i do next? thanks.
> > 
> > ------------------------------
> > 我现在使用Sogou.com的2G邮箱了，你也来试试吧! 
> > http://mail.sogou.com/recommend/sogoumail_invite_reg1.jsp?from=sogouinvitation&s_EMAIL=zengshuai%40sogou.com&username=linuxppc-embedded&FullName=linuxppc-embedded&Email=linuxppc-embedded%40ozlabs.org&verify=755eff4e640bdcfc57d93cbd8b0a9cb7
> > 
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 
> ------------------------------
> 我现在使用Sogou.com的2G邮箱了，你也来试试吧! 
> http://mail.sogou.com/recommend/sogoumail_invite_reg1.jsp?from=sogouinvitation&s_EMAIL=zengshuai%40sogou.com&username=zengshuai&FullName=zengshuai&Email=zengshuai%40sogou.com&verify=9cab69a60842dbdbc5ad49cbd78e2e11


------------------------------
我现在使用Sogou.com的2G邮箱了，你也来试试吧! 
http://mail.sogou.com/recommend/sogoumail_invite_reg1.jsp?from=sogouinvitation&s_EMAIL=zengshuai%40sogou.com&username=Linuxppc-embedded&FullName=Linuxppc-embedded&Email=Linuxppc-embedded%40ozlabs.org&verify=777667b18eda2b5dd1bbd47542afad9b
