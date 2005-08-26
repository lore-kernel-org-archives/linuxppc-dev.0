Return-Path: <wd@denx.de>
Received: from mailout09.sul.t-online.com (mailout09.sul.t-online.com
	[194.25.134.84]) by ozlabs.org (Postfix) with ESMTP id C135968052
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Aug 2005 18:48:44 +1000 (EST)
To: =?UTF-8?Q?=E5=BE=90=E5=B0=8F=E5=A8=81=E7=9A=84EMAIL?= <rober@opnet.com.tw>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 26 Aug 2005 08:48:44 +0800."
	<1125017324.7073.4.camel@banana>
Date: Fri, 26 Aug 2005 10:48:29 +0200
Sender: wd@denx.de
Message-Id: <20050826084829.86B07352589@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: rebuild net-snmp 5.0.6 from eldk 3.1.1 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <1125017324.7073.4.camel@banana> you wrote:
> 
>     Anybody know how to setting fedora linux 3 environment to cross
> compile netsnmp 5.0.6
> contain in the eldk 3.1.1.

This is documented in detail in the DULG, please see
http://www.denx.de/twiki/bin/view/DULG/ELDKRebuildingComponents#Section_3.7.2.

Make sure to follow the instructions, especially those about  setting
up your PATH!

>    I'v try to modify net-snmp.spec for using pcc_8xx-gcc, but still got
> probems.

The unmodified spec file works just fine.

> Executing(%prep): /bin/sh -e /opt/eldk/var/tmp/rpm-tmp.4936
...
> + ./configure --host=i386-pc-linux-gnu --build=i386-pc-linux-gnu --
> target=ppc-denx-linux --program-prefix= --prefix=/usr --exec-prefix=/usr
> --bindir=/usr/bin --sbindir=/usr/sbin --sysconfdir=/etc --
> datadir=/usr/share --includedir=/usr/include/net-snmp --libdir=/usr/lib
> --libexecdir=/usr/libexec --localstatedir=/var --sharedstatedir=/usr/com
> --mandir=/usr/share/man --infodir=/usr/share/info --host=ee --enable-
                                                      ^^^^^^^
...
> checking host system type... Invalid configuration `ee': machine `ee'
> not recognized

You modified the spec file in a way that breaks it. Don't do this.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
People seldom know what they want until you give them what  they  ask
for.
