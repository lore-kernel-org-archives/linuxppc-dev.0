Return-Path: <timur.tabi@gmail.com>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) by ozlabs.org (Postfix) with ESMTP id 681EA1007D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 14 Nov 2010 09:44:03 +1100 (EST)
Received: by iwn2 with SMTP id 2so5368113iwn.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 13 Nov 2010 14:44:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <54AAF9B7-9533-45B8-9C49-A964203AF707@kernel.crashing.org>
References: <1289477789-10651-1-git-send-email-leoli@freescale.com>
	<54AAF9B7-9533-45B8-9C49-A964203AF707@kernel.crashing.org>
From: Timur Tabi <timur.tabi@gmail.com>
Date: Sat, 13 Nov 2010 16:43:30 -0600
Message-ID: <AANLkTi=1nutREorMFY2VJyUYQD0SHfiSeskw-u22P+R-@mail.gmail.com>
Subject: Re: [PATCH v2] fsldma: add support to 36-bit physical address
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
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

On Thu, Nov 11, 2010 at 5:56 AM, Kumar Gala <galak@kernel.crashing.org> wrote:

> Is there any reason we shouldn't set DMA_BIT_MASK(64) since the DMA block programming model allows the address to be 64-bits?

Can you explain that?  The DMA registers only have room for 36 bits
for the physical address.

-- 
Timur Tabi
Linux kernel developer at Freescale
