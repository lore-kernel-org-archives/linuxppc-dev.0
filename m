Return-Path: <hollis@penguinppc.org>
Subject: Re: [PATCH] powerpc: Add of_platform support for ROM devices
From: Hollis Blanchard <hollis@penguinppc.org>
To: Vitaly Wool <vwool@ru.mvista.com>
In-Reply-To: <20061120163239.f9a38fc1.vwool@ru.mvista.com>
References: <20061120163239.f9a38fc1.vwool@ru.mvista.com>
Content-Type: text/plain
Date: Mon, 20 Nov 2006 09:48:24 -0600
Message-Id: <1164037704.10815.11.camel@diesel>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-11-20 at 16:32 +0300, Vitaly Wool wrote:
> +
> +    Required properties:
> +
> +     - device_type : has to be "rom"
> +     - compatible : Should specify what this ROM device is compatible with
> +       (i.e. "onenand"). Currently, this is most likely to be "direct-mapped"
> +       (which corresponds to the MTD physmap mapping driver).
> +     - regs : Offset and length of the register set (or memory mapping) for
> +       the device.
> +
> +    Recommended properties :
> +
> +     - bank-width : Width of the flash data bus in bytes. Required
> +       for the NOR flashes (compatible == "direct-mapped" and others) ONLY.

Maybe you should put this in the Required section then, with a note that
it's only Recommended for non-NOR flashes. I can easily imagine somebody
ignoring every Recommendation section and missing this requirement.

> +     - partitions : Several pairs of 32-bit values where the first value is
> +       partition's offset from the start of the device and the second one is
> +       partition size in bytes with LSB used to signify a read only
> +       partititon (so, the parition size should always be an even number).

^^^ "partition" misspelled, twice. :)

-Hollis
