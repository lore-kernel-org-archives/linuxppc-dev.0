Message-ID: <399118FD.BFE221A3@vas-gmbh.de>
Date: Wed, 09 Aug 2000 10:40:29 +0200
From: Frank Przybylski <Frank.Przybylski@vas-gmbh.de>
MIME-Version: 1.0
To: "'linuxppc-embedded@lists.linuxppc.org'"
 <linuxppc-embedded@lists.linuxppc.org>
CC: Dan Malek <dan@netx4.com>, Matthew Locke <mlocke@mvista.com>
Subject: Re: I2C,SPI and QMC
References: <819E3E914E0AD11194DE00805F0D100B0138B86C@fbi.infocom.dk> <398EE632.D9A867E@vas-gmbh.de> <398EF507.AA56B9FF@mvista.com> <39905F08.F3E75A26@embeddededge.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thank you for your answers. As this is going to be a new hardware I wanted to be
on the secure side. So I'm going to try the patch with the software option on
the very same pins as a fall back option.

    Frank

Dan Malek wrote:
>
> Matthew Locke wrote:
>
> > I have successfully used SPI with ethernet on SCC2 with the microcode
> > patch.
>
> Better than me :-)!  I left my attempt at microcode patches around
> someplace, but was never able to make them work very well.
>
> Depending upon your SPI or I2C requirements, you may just be able to
> toggle the pins in software.  This is all I did.
>
>         -- Dan

--
===============================================================================
Frank Przybylski,VAS GmbH,Gotenstr.6,20097 Hamburg,GERMANY,TEL:+49-40-238568-14
   mailto:Frank.Przybylski@vas-gmbh.de , visit us at http://www.vas-gmbh.de
===============================================================================

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
