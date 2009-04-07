Return-Path: <sr@denx.de>
From: Stefan Roese <sr@denx.de>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/4 v2] mtd/powerpc: Remove unused "device-width" property
Date: Tue, 7 Apr 2009 18:54:16 +0200
References: <1239093575-12147-1-git-send-email-sr@denx.de>
	<49DB8271.8050501@freescale.com>
In-Reply-To: <49DB8271.8050501@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200904071854.16818.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org,
	linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 07 April 2009, Scott Wood wrote:
> Stefan Roese wrote:
> > This property is unused. It's not handled as all by the physmap_of
> > driver. So let's remove it from the documentation.
> >
> > Signed-off-by: Stefan Roese <sr@denx.de>
> > CC: Grant Likely <grant.likely@secretlab.ca>
>
> The device tree describes the hardware, not what Linux happens to do
> with it at the moment.
>
> I'd rather keep it.

I find it rather confusing to "see" such bindings that are not supported. One 
could expect something to happen/change after defining this property. So in 
general I think adding unsupported properties to the Documentation is a bad 
idea. But that's just my 2 cents. If the general opinion is to keep this 
property, I'll keep it in of course.

Best regards,
Stefan
