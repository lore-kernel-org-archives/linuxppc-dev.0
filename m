Return-Path: <wd@denx.de>
Received: from mailout02.sul.t-online.com (mailout02.sul.t-online.com
	[194.25.134.17]) by ozlabs.org (Postfix) with ESMTP id D3D972BDEB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Nov 2004 07:37:54 +1100 (EST)
To: Kumar Gala <kumar.gala@freescale.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 17 Nov 2004 13:56:28 CST."
	<C509F54D-38D2-11D9-9D5A-000393DBC2E8@freescale.com>
Date: Wed, 17 Nov 2004 21:37:27 +0100
Sender: wd@denx.de
Message-Id: <20041117203732.29E57C1430@atlas.denx.de>
Cc: "Gala Kumar K.-galak" <kumar.gala@motorola.com>,
	Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: ELDK 3.1? 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <C509F54D-38D2-11D9-9D5A-000393DBC2E8@freescale.com> you wrote:
>
> I thought from some posts on the u-boot lists that 3.1 was going to 
> have a 85xx build as well?

Argh, you're persevering... ok, here we go.

Yes, ELDK 3.1 uses GCC-3.3.3 and binutils 2.14 to support 85xx etc.

There is a lot of new packets:

	appWeb 		1.2.2-1_5
	bzip2 		1.0.2-5_1
	bzip2-devel 	1.0.2-5_1
	bzip2-libs 	1.0.2-5_1
	dhclient 	3.0.1rc13-2
	dhcp 		3.0.1rc13-2
	dosfstools 	2.8-3
	dropbear 	0.43-1_2
	file 		3.39-9_2
	lrzsz 		0.12.20-14_1
	net-snmp 	5.0.6-17_2
	net-snmp-devel 	5.0.6-17_2
	net-snmp-utils 	5.0.6-17_2

As you can see, the focus is on network enabled devices: the powerful
"appWeb" web server, the "dropbear" SSH server, SNMP support, etc.

But there is also another group of new target packets:

	autoconf 	2.57-3_1
	byacc 		1.9-22_1
	flex 		2.5.4a-26_1
	libtool 	1.4.3-5_1
	libtool-libs 	1.4.3-5_1
	m4 		1.4.1-11_1
	patch 		2.5.4-14_1
	rpm 		4.1.1-1.8xa_7
	rpm-build 	4.1.1-1.8xa_7
	rpm-devel 	4.1.1-1.8xa_7

This is all that was missing for a more or less complete native build
environment; with the current ELDK you can  easily  build  all  those
software  packets that are difficult to handle in a cross envrionment
(like Perl, to name just  one).  If  you  have  the  resources  (RAM,
external  storage)  on  your target you can even bootstrap a complete
Linux distribution on a target system.

ELDK 3.1 comes with support for PowerPC, ARM (new: XScale explicitely
supported), and MIPS (new: little-endian systems supported).

And there is some bug fixes and other minor extensions.


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"Everything should be made as simple as possible, but not simpler."
                                                    - Albert Einstein
