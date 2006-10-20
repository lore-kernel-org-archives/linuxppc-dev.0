Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id D032867BCC
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 21 Oct 2006 04:48:36 +1000 (EST)
To: tran vanle <vantranbk@yahoo.com.au>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Build openssl in ELDK 3.1.1 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 20 Oct 2006 22:46:51 +1000."
	<20061020124651.41291.qmail@web33003.mail.mud.yahoo.com>
Date: Fri, 20 Oct 2006 20:48:33 +0200
Sender: wd@denx.de
Message-Id: <20061020184834.04B743525AB@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20061020124651.41291.qmail@web33003.mail.mud.yahoo.com> you wrote:
> 
...
> - Go to <project>/usr/src/denx/SPECS and run
>        ppc_8xx-rpmbuild  openssl.spec
> Then  I receive  in  <project>/usr/src/denx/openssl-0.9.7f/   libssl.so.0.9.7 and  openssl in <project>/usr/src/denx/openssl-0.9.7f/apps
> 
> That's OK

Good.

> But I don't know Was command openssl added in image in <project>/ppc_8xx/images? If no how i can do it ?

It does not modify the images files at all. why should it?

> I also want to rebuild kernel but i only receive vmlinux in <project>/ppc_8xx/usr/src/linux/ Was vmlinux added in image in <project>/ppc_8xx/images? If no how i can do it ?
> If I want to build an application but not in ftp://ftp.sunet.se/pub/Linux/distributions/eldk/3.1.1/ppc-linux-x86/sources/target/SRPMS/
>  how can I do?

May I suggest you start reading the documentation? It explains all
these things. See http://www.denx.de/wiki/DULG/Manual

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
1 1 was a race-horse, 2 2 was 1 2. When 1 1 1 1 race, 2 2 1 1 2.
