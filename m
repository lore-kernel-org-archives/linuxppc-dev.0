Date: Fri, 30 Jan 2004 16:35:12 -0800
From: Greg KH <greg@kroah.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	sensors@stimpy.netroedge.com,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [PATCH 2.6] Hydra i2c
Message-ID: <20040131003512.GD10465@kroah.com>
References: <Pine.LNX.4.58.0401181323130.653@callisto> <20040118124957.GA7585@lst.de> <Pine.GSO.4.58.0401251200580.20527@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.58.0401251200580.20527@waterleaf.sonytel.be>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Jan 25, 2004 at 12:22:02PM +0100, Geert Uytterhoeven wrote:
>
> Here's a new version, incorporating these comments, and making a few more
> changes:
>   - Use struct definition in <asm/hydra.h> instead of #defined offset
>   - Remove flushes are register writes, they are no longer needed
>   - Use pci_resource_start() instead of dev->resource[].start
>   - ioremap() the whole resource instead of the first 256 bytes
>   - Check for errors returned by ioremap() and i2c_bit_add_bus()
>   - Add resource management
>   - Call iounmap() in hydra_remove() instead of in i2c_hydra_exit()
>   - Let I2C_HYDRA depend on I2C and select I2C_ALGOBIT instead of depending on
>     I2C_ALGOBIT

Looks good, I've added this to my tree and will send it on in the next
round of i2c patches.

thanks,

greg k-h

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
