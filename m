Return-Path: <roman.fietze@telemotive.de>
Received: from coyote.quickmin.net (coyote.quickmin.net [217.14.112.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.quickmin.de", Issuer "smtp.quickmin.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 85554B7CF8
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 16 Apr 2010 18:28:34 +1000 (EST)
From: Roman Fietze <roman.fietze@telemotive.de>
To: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: Xorg on Fujitsu "Lime" with MPC5200b?
References: <4BC682DC.1050200@billgatliff.com>
	<201004151553.53426.roman.fietze@telemotive.de>
	<4BC7D0BA.5000502@billgatliff.com>
In-Reply-To: <4BC7D0BA.5000502@billgatliff.com>
MIME-Version: 1.0
Message-ID: <201004161028.27637.roman.fietze@telemotive.de>
Date: Fri, 16 Apr 2010 10:28:27 +0200
Content-Type: Text/Plain;
  charset="iso-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Bill,

On Friday 16 April 2010 04:51:38 Bill Gatliff wrote:

> Apparently, there are several similar modifications that need to be
> made, ...

I'm SW-Engineer, so I assume HW, that's always a good bet. ;)

Please take care, that I forgot to tell you that my X server runs well
on a Futjitsu 86295 chip, also connected to a MPC5200(B). I silently
assumed that those two are identical in terms of byte ordering and
(non) existant automatic byte swapping.

At least, when you get a black screen when copying out nothing, you
might be able to copy over some fixed pattern to find out what bits
cause what, e.g. start writing 0x03 and shift that pattern left every
16 scanlines.

In what mode is your X server running? 16/24/32 bit? DirectColor, etc?


Roman

=2D-=20
Roman Fietze                Telemotive AG B=FCro M=FChlhausen
Breitwiesen                              73347 M=FChlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de
