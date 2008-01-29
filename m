Return-Path: <olof@lixom.net>
Date: Tue, 29 Jan 2008 09:15:11 -0600
From: Olof Johansson <olof@lixom.net>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 8/8] Cell IOMMU fixed mapping support
Message-ID: <20080129151511.GA18975@lixom.net>
References: <56662c291890f09835ef7251f9b86f70fbee3ad2.1201616038.git.michael@ellerman.id.au>
	<1cbc0deea968ece13756e3c86ec3af0b7586b80b.1201616038.git.michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1cbc0deea968ece13756e3c86ec3af0b7586b80b.1201616038.git.michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 30, 2008 at 01:14:03AM +1100, Michael Ellerman wrote:

> For example a machine with 4GB of memory would end up with the normal
> IOMMU window from 0-2GB and the fixed mapping window from 2GB to 6GB. In
> this case a 64-bit device wishing to DMA to 1GB would be told to DMA to
> 3GB, plus any offset required by firmware. The firmware offset is encoded
> in the "dma-ranges" property.

Shouldn't the fixed mapping be between 4G and 8G (and the offset for 1G
is at 5G), to account for the MMIO range at 2-4G?


-Olof
