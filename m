Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BBA0CDDF7B
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 13:24:48 +1100 (EST)
Message-Id: <9D668111-9774-4D45-944E-3C3C0EE47A09@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Dan Williams <dan.j.williams@intel.com>
In-Reply-To: <e9c3a7c20803271237x1b2c3a2ci6837c5e2d5288c95@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] fsldma: The MPC8377MDS board device tree node for fsldma
	driver
Date: Thu, 27 Mar 2008 21:23:54 -0500
References: <1206517356-11209-1-git-send-email-wei.zhang@freescale.com>
	<1206517356-11209-2-git-send-email-wei.zhang@freescale.com>
	<e9c3a7c20803271237x1b2c3a2ci6837c5e2d5288c95@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 27, 2008, at 2:37 PM, Dan Williams wrote:
> On Wed, Mar 26, 2008 at 12:42 AM, Zhang Wei  
> <wei.zhang@freescale.com> wrote:
>> The fsldma driver is tested on MPC8377MDS board.
>> The patch adds fsldma driver support into MPC8377MDS device tree.
>>
>> Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
>> ---
>>  arch/powerpc/boot/dts/mpc8377_mds.dts |   27 ++++++++++++++++++++++ 
>> +++++
>>  1 files changed, 27 insertions(+), 0 deletions(-)
>
> I think this patch should probably go through the powerpc tree, or
> -mm.  I'll pick up the ones that touch either drivers/dma or
> crypto/async_tx.

Can you resend and CC me.  I'll pick it up and push through via the  
powerpc tree.

I want to make one update to the driver to support the "proper" names  
we document for compatible properties.

(uugh too many things to do)

- k
