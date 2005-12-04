Return-Path: <zengshuai@sogou.com>
Received: from sogoumx75.mail.sogou.com (unknown [61.135.132.136])
	by ozlabs.org (Postfix) with ESMTP id 73DB56886D
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  4 Dec 2005 12:07:44 +1100 (EST)
Message-ID: <14801389.1133657729738.JavaMail.postfix@mx3.mail.sohu.com>
Date: Sun, 4 Dec 2005 08:55:29 +0800 (CST)
From: <zengshuai@sogou.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Cc: ppc <linuxppc-embedded@ozlabs.org>
Subject: =?gb2312?b?u9i4tDpSZTogbWZzcHIgcjAsNjM4LiBXaHkgNjM4ID8=?=
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

thanks.i have found it.
but how we can get IMMR in PQ2 ? still "mfspr r0,638"?

-----  原文  -----
From: Kumar Gala 
Cc: ppc 
Subject: Re: mfspr r0,638. Why 638 ?
Sent: Sun Dec 04 00:16:50 CST 2005

> This is 8xx (PQ1) SPR.  If you look one of those user manuals you  
> will see it.
> 
> - kumar
> 
> On Dec 3, 2005, at 4:38 AM, <zengshuai@sogou.com>  
> <zengshuai@sogou.com> wrote:
> 
> > We know "mfspr r0,638" can get the IMMR.
> > But why?
> > I checked "MPC82xx Reference Manual","G2 PowerPC&#8482; Core  
> > Reference Manual","Programming Environments Manual",
> > but I didn't find any word about that.How did the person who first  
> > known know?
> >
> > "G2 PowerPC&#8482; Core Reference Manual"  where is the "SPR 638"?
> > Table 3-33. Implementation-Specific SPR Encodings (mfspr)
> > Decimal spr[5?9] spr[0?4] RegisterName Access
> > 58 00001 11010 CSRR0  Supervisor
> > 59 00001 11011 CSRR1  Supervisor
> > 276 01000 10100 SPRG4  Supervisor
> > 277 01000 10101 SPRG5  Supervisor
> > 278 01000 10110 SPRG6  Supervisor
> > 279 01000 10111 SPRG7  Supervisor
> > 286 01000 11110 SVR  Supervisor
> > 309 01001 10101 IBCR  Supervisor
> > 310 01001 10110 DBCR  Supervisor
> > 311 01001 10111 MBAR  Supervisor
> > 317 01001 11101 DABR2  Supervisor
> > 560 10001 10000 IBAT4U  Supervisor
> > 561 10001 10001 IBAT4L  Supervisor
> > 562 10001 10010 IBAT5U  Supervisor
> > 563 10001 10011 IBAT5L  Supervisor
> > 564 10001 10100 IBAT6U  Supervisor
> > 565 10001 10101 IBAT6L  Supervisor
> > 566 10001 10110 IBAT7U  Supervisor
> > 567 10001 10111 IBAT7L  Supervisor
> > 568 10001 11000 DBAT4U  Supervisor
> > 569 10001 11001 DBAT4L  Supervisor
> > 570 10001 11010 DBAT5U  Supervisor
> > 571 10001 11011 DBAT5L  Supervisor
> > 572 10001 11100 DBAT6U  Supervisor
> > 573 10001 11101 DBAT6L Supervisor
> > 574 10001 11110 DBAT7U  Supervisor
> > 575 10001 11111 DBAT7L  Supervisor
> > 976 11110 10000 DMISS Supervisor
> > 977 11110 10001 DCMP Supervisor
> > 978 11110 10010 HASH1 Supervisor
> > 979 11110 10011 HASH2 Supervisor
> > 980 11110 10100 IMISS Supervisor
> > 981 11110 10101 ICMP Supervisor
> > 982 11110 10110 RPA Supervisor
> > 1008 11111 10000 HID0 Supervisor
> > 1009 11111 10001 HID1 Supervisor
> > 1010 11111 10010 IABR Supervisor
> > 1011 11111 10011 HID2 Supervisor
> > 1013 11111 10101 DABR  Supervisor
> > 1018 11111 11010 IABR2  Supervisor
> >
> > ------------------------------
> > 我现在使用Sogou.com的2G邮箱了，你也来试试吧!
> > http://mail.sogou.com/recommend/sogoumail_invite_reg1.jsp? 
> > from=sogouinvitation&s_EMAIL=zengshuai% 
> > 40sogou.com&username=linuxppc-embedded&FullName=linuxppc- 
> > embedded&Email=linuxppc-embedded% 
> > 40ozlabs.org&verify=755eff4e640bdcfc57d93cbd8b0a9cb7
> >
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 


------------------------------
我现在使用Sogou.com的2G邮箱了，你也来试试吧! 
http://mail.sogou.com/recommend/sogoumail_invite_reg1.jsp?from=sogouinvitation&s_EMAIL=zengshuai%40sogou.com&username=&FullName=&Email=&verify=e197bd6dbd1fc7f8d6a035729df08d63
