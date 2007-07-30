Return-Path: <Marc.Dietrich@ap.physik.uni-giessen.de>
Received: from merkurneu.hrz.uni-giessen.de (merkurneu.hrz.uni-giessen.de
	[134.176.2.3]) by ozlabs.org (Postfix) with ESMTP id 353C7DDE04
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jul 2007 22:59:05 +1000 (EST)
From: Marc Dietrich <Marc.Dietrich@ap.physik.uni-giessen.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: Using video memory on PS3 e.g. as SWAP?
Date: Mon, 30 Jul 2007 14:24:31 +0200
References: <200707291904.55700.rene@exactcode.de>
In-Reply-To: <200707291904.55700.rene@exactcode.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200707301424.43750.marc.dietrich@ap.physik.uni-giessen.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Am Sunday 29 July 2007 19:04 schrieb Ren=E9 Rebe:
> Hi all,
>
> looking at the PS3 as one of the few PowerPC workstation options the RAM
> is obviously quite limitted with just 256MB. I wonder if the 256MB of
> video memory can be mapped or at least be used as super-fast SWAP?

look here:
http://forums.ps2dev.org/viewtopic.php?t=3D8267

but the write speed is much slower than disk.

> Or are there news regarding accessing the video chip from Linux beside
> the unaccelerated frame-buffer?
>
> Regards,

=2D-=20
	"The enemy commits atrocities knowingly; if we make unfortunate mistakes, =
it=20
is involuntary."
		 Lord Arthur Ponsonby, "Falsehood in Wartime: Propaganda Lies of the Firs=
t=20
World War", 1928
