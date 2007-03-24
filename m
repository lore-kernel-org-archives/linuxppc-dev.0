Return-Path: <sr@denx.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.189])
	by ozlabs.org (Postfix) with ESMTP id 67455DDEEA
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 24 Mar 2007 17:12:36 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: AVNET 440GX board
Date: Sat, 24 Mar 2007 07:12:54 +0100
References: <393e3a4b0703221234n20eee581g6cbf9af9be2c5ebb@mail.gmail.com>
	<200703230722.25498.sr@denx.de>
	<393e3a4b0703231145qc16b305x58389e3ba08c867b@mail.gmail.com>
In-Reply-To: <393e3a4b0703231145qc16b305x58389e3ba08c867b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200703240712.54764.sr@denx.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Ken,

On Friday 23 March 2007 19:45, Ken Sakurai wrote:
> > I don't know the AVNET 440GX eval board. Is it _identical_ to the
> > IBM/AMCC Ocotea? If not you will most likely have no luck with this
> > image. You will have to port Linux to this special board.
>
> yeah, sounds like. I was so optimistic that Linux is kind of primary OS for
> any ppc board  when I choosed this board :-)
>
> I was just using the elf image, instead of uimage.
> '6501A8C0.img' is refereing zImage.img which is Linux elf image.
> It looks to me that the bootelf command interprets ELF format corrently.
>
> As you sugested, I also made uImage and used bootm to boot it.
> But no luck. Here is the log.

Of course you had no luck, since the Ocotea uImage can't work on a different 
hardware like the AVNET board. Again, you have to port Linux to this platform 
first. And you need to know detailed information for this procedure 
(schematics...).

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH, HRB 165235 Munich, CEO: Wolfgang Denk
Office:  Kirchenstr. 5,       D-82194 Groebenzell,            Germany
=====================================================================
