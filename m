Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1C3C2DDF20
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 05:02:25 +1000 (EST)
Date: Thu, 19 Jul 2007 14:02:15 -0500
From: Scott Wood <scottwood@freescale.com>
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH] Treat ISI faults as read faults on classic 32-bit PowerPC
Message-ID: <20070719190215.GA30593@ld0162-tx32.am.freescale.net>
References: <11847726193856-git-send-email-segher@kernel.crashing.org>
	<5d56173bee3f9ea0050aa508e7f27cc932af7229.1184104284.git.segher@kernel.crashing.org>
	<18078.43412.493174.590540@cargo.ozlabs.ibm.com>
	<1184863497.16820.8.camel@ld0161-tx32>
	<5B45DD7F-1916-4E92-B0F6-6D1C11EF391B@kernel.crashing.org>
	<1184871420.16820.15.camel@ld0161-tx32>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1184871420.16820.15.camel@ld0161-tx32>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 19, 2007 at 01:57:00PM -0500, Jon Loeliger wrote:
> Needless to say, one that showed the problem beforehand. :-)
> But to be precise:
> 
> [root:~] ls -lsa /usr/lib/libglib*
>    0 lrwxrwxrwx    1 18005314 24012          21 Aug 15  2005 /usr/lib/libglib-1.2.so.0 -> libglib-1.2.so.0.0.10*
>  536 -rwxrwxr-x    1 18005314 24012      540931 Apr  8  2003 /usr/lib/libglib-1.2.so.0.0.10*
> 1064 -rw-rw-r--    1 18005314 24012     1084256 Apr  8  2003 /usr/lib/libglib.a
>    4 -rwxrwxr-x    1 18005314 24012         662 Apr  8  2003 /usr/lib/libglib.la*
>    0 lrwxrwxrwx    1 18005314 24012          21 Aug 15  2005 /usr/lib/libglib.so -> libglib-1.2.so.0.0.10*

glib != glibc.

-Scott
