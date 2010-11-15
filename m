Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3CF2FB7103
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Nov 2010 02:17:12 +1100 (EST)
Subject: Re: [PATCH v2] fsldma: add support to 36-bit physical address
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <AANLkTi=1nutREorMFY2VJyUYQD0SHfiSeskw-u22P+R-@mail.gmail.com>
Date: Mon, 15 Nov 2010 09:16:57 -0600
Message-Id: <3B38AD35-39A2-4A54-8109-65D6DE436227@kernel.crashing.org>
References: <1289477789-10651-1-git-send-email-leoli@freescale.com>
	<54AAF9B7-9533-45B8-9C49-A964203AF707@kernel.crashing.org>
	<AANLkTi=1nutREorMFY2VJyUYQD0SHfiSeskw-u22P+R-@mail.gmail.com>
To: Timur Tabi <timur.tabi@gmail.com>
Cc: dan.j.williams@intel.com, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 13, 2010, at 4:43 PM, Timur Tabi wrote:

> On Thu, Nov 11, 2010 at 5:56 AM, Kumar Gala =
<galak@kernel.crashing.org> wrote:
>=20
>> Is there any reason we shouldn't set DMA_BIT_MASK(64) since the DMA =
block programming model allows the address to be 64-bits?
>=20
> Can you explain that?  The DMA registers only have room for 36 bits
> for the physical address.

The programming model (if you look at the free-space in the registers =
and data structures) supports a 64-bit address.  I'm trying to avoid =
changing the driver in the future if we have >36-bit.  However this is =
such a minor worry that I'll stop and just ack the patch as is.

- k=
