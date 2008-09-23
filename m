Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 8E1F2DDF5F
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 04:52:06 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: AMCC 440 SPI question
Date: Tue, 23 Sep 2008 20:50:28 +0200
References: <48D90D5D.5000105@harris.com>
	<20080923155026.GA14099@yoda.jdub.homelinux.org>
In-Reply-To: <20080923155026.GA14099@yoda.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200809232050.29119.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 23 September 2008, Josh Boyer wrote:
> On Tue, Sep 23, 2008 at 11:38:05AM -0400, Steven A. Falco wrote:
> >The yosemite.dts has the following entry, which leads me to believe
> >that there is SPI support.  I'd like to do something similar for a
> >Sequoia board, but looking in Josh's "next" branch, I don't see any
> >driver that would recognize the spi-440ep string.  So my question is,
> >is there a SPI driver for the PPC440, that is .dts aware?
>
> There is no mainline driver, no.  There might be one in the DENX kernel
> tree.

Correct. There is one in the "t1000-denx" branch of our linux-2.6-denx 
repository. But it's not ready for upstream merge yet. I already started 
cleaning up the driver and extracting the GPIO stuff into a 4xx GPIOLIB 
implementation. Hopefully I'll find the time to finish this and push the 4xx 
SPI & GPIOLIB stuff in the next 2-3 weeks.

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
=====================================================================
