Return-Path: <sprasad@bivio.net>
Received: from corpexc01.corp.networkrobots.com (nofear-snat.bivio.net
	[216.142.75.231]) by ozlabs.org (Postfix) with ESMTP id 03A90DE10A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Jul 2008 06:08:20 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Re: increase lowmem value for ppc
Date: Thu, 17 Jul 2008 13:07:48 -0700
Message-ID: <D83235F0F3C86D4D889D8B9A0DA8C6D702B647CC@corpexc01.corp.networkrobots.com>
In-Reply-To: <mailman.2286.1216296226.2883.linuxppc-embedded@ozlabs.org>
References: <mailman.2286.1216296226.2883.linuxppc-embedded@ozlabs.org>
From: "Siva Prasad" <sprasad@bivio.net>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Marco Stornelli wrote:

> Upgrading to a 2.6.x kernel may solve the problem, but it needs a lot
of=20
> effort. Does 2.6.x kernel support 2G physical memory?
>=20
It's the same. Some architecture have 36-bit addressing, but I don't=20
know if the latest kernel has the support for this feature for powerpc.
>=20

I think recently there were some patches with 2.6.26-rcx to support
36-bit addressing and changed the addressing to phys_addr_t type from
unsigned long, and few other changed. I think this should be available
starting 2.6.26 version.
