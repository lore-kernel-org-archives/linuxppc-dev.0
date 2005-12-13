Return-Path: <zengshuai@sogou.com>
Received: from sogoumx75.mail.sogou.com (unknown [61.135.132.136])
	by ozlabs.org (Postfix) with ESMTP id 1D63C6888D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Dec 2005 15:01:09 +1100 (EST)
Message-ID: <31064960.1134445714325.JavaMail.postfix@mx3.mail.sohu.com>
Date: Tue, 13 Dec 2005 11:48:34 +0800 (CST)
From: <zengshuai@sogou.com>
To: "Wolfgang Denk" <wd@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Cc: ppc <linuxppc-embedded@ozlabs.org>
Subject: Re:Re: Can we compile them with eldk and debug them with BDI2000? 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

thanks a lot.Would you give me more inf,please?
There were a test.c.
When we use "ppc_6xx-gcc -o test test.c",we can get a "test" which can running in Linux.
How can we get a "test" which can running in bareboard and be debuged using the BDI2000?
Would you give a flag example?
 
-----  Original Message  -----
From: Wolfgang Denk 
To: zengshuai@sogou.com 
Cc: ppc 
Subject: Re: Can we compile them with eldk and debug them with BDI2000? 
Sent: Mon Dec 12 21:26:57 CST 2005

> In message <4069241.1134390336250.JavaMail.postfix@mx3.mail.sohu.com> you wrote:
> > There are some example C programs in freescale's web.
> > They don't work in linux but bareboard.
> > Can we compile them with eldk and debug them with BDI2000? 
> 
> Yes. You may have to set up your own linker script, though. It  would
> be probably much easier to run such code as standalone application in
> U-Boot (and yes, this too can be compiled using the ELDK and debugged
> using the BDI).
> 
> Best regards,
> 
> Wolfgang Denk
> 
> -- 
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
> We are all agreed that your  theory  is  crazy.  The  question  which
> divides  us  is  whether it is crazy enough to have a chance of being
> correct. My own feeling is that it is not crazy enough.  - Niels Bohr


------------------------------
?????Sogou.com?2G??????????! 
http://mail.sogou.com/recommend/sogoumail_invite_reg1.jsp?from=sogouinvitation&s_EMAIL=zengshuai%40sogou.com&username=&FullName=&Email=&verify=e197bd6dbd1fc7f8d6a035729df08d63
