Return-Path: <scottwood@freescale.com>
Date: Fri, 27 Jun 2008 12:49:53 -0500
From: Scott Wood <scottwood@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc/bootwrapper: Add documentation of boot wrapper
	targets
Message-ID: <20080627174953.GA12627@ld0162-tx32.am.freescale.net>
References: <20080625202104.30114.47902.stgit@trillian.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080625202104.30114.47902.stgit@trillian.secretlab.ca>
Cc: paulus@samba.org, petermendham@computing.dundee.ac.uk,
	linuxppc-dev@ozlabs.com, john.linn@xilinx.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 25, 2008 at 01:21:04PM -0700, Grant Likely wrote:
> +   zImage.%:		Image usable by OpenFirmware.  Image expects firmware
> +			to provide the device tree using OpenFirmware
> +			interfaces.  Typically general purpose hardware uses
> +			this image format.

Is it really specific to Open Firmware?  I'd say something like: "Image
format usable by the firmware natively shipped on the board, if not
covered by another image type.  A device tree is not embedded into the
image."

-Scott
