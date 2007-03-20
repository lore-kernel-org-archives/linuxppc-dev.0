Return-Path: <sr@denx.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.189])
	by ozlabs.org (Postfix) with ESMTP id 462D0DDF3F
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 16:36:38 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: michael@ellerman.id.au
Subject: Re: [PATCH] [PPC32] ADMA support for PPC 440SPe processors.
Date: Tue, 20 Mar 2007 06:39:06 +0100
References: <20070315232956.37DAB353A6C@atlas.denx.de>
	<1174320799.5044.21.camel@localhost.localdomain>
	<1174359995.10827.10.camel@concordia.ozlabs.ibm.com>
In-Reply-To: <1174359995.10827.10.camel@concordia.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200703200639.07868.sr@denx.de>
Cc: Dan Williams <dan.j.williams@gmail.com>, linux-raid@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 20 March 2007 04:06, Michael Ellerman wrote:
> On Mon, 2007-03-19 at 17:13 +0100, Benjamin Herrenschmidt wrote:
> > BTW folks. Would it be hard to change your spe_ prefixes to something
> > else ? There's already enough confusion between the freescale SPE unit
> > and the cell SPEs :-)
> >
> > (such confusion is annoying when grepp'ing for code that might touch a
> > given functionality for example).
>
> Please please please!

OK. Who can resist so much pleading. ;-)

Best regards,
Stefan
