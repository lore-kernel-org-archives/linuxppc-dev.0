Return-Path: <scottwood@freescale.com>
Message-ID: <49DB8271.8050501@freescale.com>
Date: Tue, 07 Apr 2009 11:42:25 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH 3/4 v2] mtd/powerpc: Remove unused "device-width" property
References: <1239093575-12147-1-git-send-email-sr@denx.de>
In-Reply-To: <1239093575-12147-1-git-send-email-sr@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Stefan Roese wrote:
> This property is unused. It's not handled as all by the physmap_of
> driver. So let's remove it from the documentation.
> 
> Signed-off-by: Stefan Roese <sr@denx.de>
> CC: Grant Likely <grant.likely@secretlab.ca>

The device tree describes the hardware, not what Linux happens to do 
with it at the moment.

I'd rather keep it.

-Scott
