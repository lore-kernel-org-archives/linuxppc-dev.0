Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound5-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B4525DDEF0
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jun 2007 08:27:47 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [patch 30/33] PS3: Bootwrapper support.
Date: Thu, 21 Jun 2007 15:24:54 -0700
Message-ID: <591B6A09961C354991CD653B274DC8C203E0521D@ussdixms03.am.sony.com>
References: <46730D8A.9090309@am.sony.com><951969d2021fe6e78917ef8bdb47cf6f@bga.com><20070618225537.GA19966@mag.az.mvista.com><46771CE7.8040901@am.sony.com>
	<18039.31575.330603.260727@cargo.ozlabs.ibm.com>
From: "Levand, Geoffrey" <Geoffrey.Levand@am.sony.com>
To: "Paul Mackerras" <paulus@samba.org>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>




-----Original Message-----
From: Paul Mackerras [mailto:paulus@samba.org]
Sent: Mon 6/18/2007 11:44 PM
To: Levand, Geoffrey
Cc: Mark A. Greer; ppcdev; Milton Miller
Subject: Re: [patch 30/33] PS3: Bootwrapper support.
=20
Geoff Levand writes:

> This is from the comment the patch adds to the wrapper script.  I =
think
> it gives you what you need:
>=20
> +ps3)
> +    # The ps3's loader supports loading gzipped binary images from =
flash
> +    # rom to addr zero. The loader enters the image at addr 0x100.  A
> +    # bootwrapper overlay is use to arrange for the kernel to be =
loaded
> +    # to addr zero and to have a suitable bootwrapper entry at 0x100.
> +    # To construct the rom image, 0x100 bytes from offset 0x100 in =
the
> +    # kernel is copied to the bootwrapper symbol =
__system_reset_kernel.
> +    # The 0x100 bytes at the bootwrapper symbol =
__system_reset_overlay is
> +    # then copied to offset 0x100.  At runtime the bootwrapper =
program
> +    # copies the 0x100 bytes at __system_reset_kernel to addr 0x100.

Yes, that is useful, but Mark is right, your patch description is a
bit terse, and something like that in the patch description would be
useful.

I prepared a new patch with this description and was waiting a while to =
get
all the comments.  I'll send it out soon.

-Geoff
