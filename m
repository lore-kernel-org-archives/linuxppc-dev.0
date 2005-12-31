Return-Path: <sr@denx.de>
Received: from natblindhugh.rzone.de (natblindhugh.rzone.de [81.169.145.175])
	by ozlabs.org (Postfix) with ESMTP id 4DE3D6892B
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 31 Dec 2005 23:14:37 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-embedded@ozlabs.org
Date: Sat, 31 Dec 2005 13:14:29 +0100
References: <20051230211710.72899352597@atlas.denx.de>
In-Reply-To: <20051230211710.72899352597@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200512311314.30168.sr@denx.de>
Cc: "Kiran Kumar.A" <kiranf5@lycos.com>
Subject: Re: Regarding booting 440 gr board / ibm emac driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Friday 30 December 2005 22:17, Wolfgang Denk wrote:
> In message <20051230112111.58191CA092@ws7-4.us4.outblaze.com> you wrote:
> > This is kiran here. I'm working on 440GR (Yosemite) board to boot
> > linux-2.6 .13.4.
>
> Don't use old code. Please use the current version.
>
> > What could be the issue? Do we need to modify the driver for MAC address
> > is sue??
>
> Just use current code. You can find ready to  run  binaries  and  the
> corresponding sources (git repository) on our server:
>
> ftp://ftp.denx.de/pub/u-boot/images/amcc/yosemite/u-boot.bin
> ftp://ftp.denx.de/pub/linux/images/amcc/yosemite/uImage
> and http://www.denx.de/cgi-bin/gitweb.cgi?p=linux-2.6-denx.git
> (git tag "DENX-2005-12-03-2208" or later).

Just a quick note, since you mentioned using 440GR (Yosemite): Yosemite is the 
eval board for the 440EP and Yellowstone is the eval board for the 440GR. 
Images for both boards are available at the site referenced by Wolfgang.

Best regards,
Stefan
