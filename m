Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id F2BB0688B7
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Dec 2005 19:18:15 +1100 (EST)
To: zengshuai@sogou.com
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 13 Dec 2005 11:48:34 +0800."
	<31064960.1134445714325.JavaMail.postfix@mx3.mail.sohu.com>
Date: Tue, 13 Dec 2005 09:18:13 +0100
Sender: wd@denx.de
Message-Id: <20051213081813.E5175353F76@atlas.denx.de>
Cc: ppc <linuxppc-embedded@ozlabs.org>
Subject: Re: Can we compile them with eldk and debug them with BDI2000? 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <31064960.1134445714325.JavaMail.postfix@mx3.mail.sohu.com> you wrote:
> thanks a lot.Would you give me more inf,please?

I'm afraid this is off topic on this list.

> There were a test.c.
> When we use "ppc_6xx-gcc -o test test.c",we can get a "test" which can running in Linux.
> How can we get a "test" which can running in bareboard and be debuged using the BDI2000?
> Would you give a flag example?

See the U-Boot source code. U-Boot itself is just such a bare-silicon
application program (a pretty complex  one,  though).  Also  see  the
examples/ directory which contains code for several simple standalone
applications within the U-Boot context.

Note that you will have to understand how the linker works, and  know
exactly what you are doing.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Four thousand throats may be cut in one night by a running man.
	-- Klingon Soldier, "Day of the Dove", stardate unknown
