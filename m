Return-Path: <olof@lixom.net>
Date: Mon, 17 Mar 2008 19:21:31 -0500
From: Olof Johansson <olof@lixom.net>
To: "Nelson, Shannon" <shannon.nelson@intel.com>
Subject: Re: [PATCH v2] pasemi_dma: Driver for PA Semi PWRficient on-chip
	DMAengine
Message-ID: <20080318002131.GA382@lixom.net>
References: <20080306233900.GA3969@lixom.net> <20080316213002.GA2589@lixom.net>
	<BAE9DCEF64577A439B3A37F36F9B691C043E6716@orsmsx418.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BAE9DCEF64577A439B3A37F36F9B691C043E6716@orsmsx418.amr.corp.intel.com>
Cc: hskinnemoen@atmel.com, "Sosnowski, Maciej" <maciej.sosnowski@intel.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	pasemi-linux@ozlabs.org, "Williams, Dan J" <dan.j.williams@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Mon, Mar 17, 2008 at 01:34:05PM -0700, Nelson, Shannon wrote:

> In the future please copy Maciej as one of "the DMA guys" as he has
> taken over ioatdma for me.  Beyond that, one little picky comment
> below...

Time to set up a list, or have everyone monitor lkml, I'd say. I'd
prefer the former.

> >+static unsigned int channels = 4;
> >+module_param(channels, uint, S_IRUGO);
> >+MODULE_PARM_DESC(channels, "Number of channels for copy 
> >(default: 2)");
> 
> Is the number of channels defaulting to 2 or 4?

Ah, yes, good catch.


-Olof
