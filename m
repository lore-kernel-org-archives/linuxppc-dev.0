Return-Path: <domen.puncer@telargo.com>
Received: from out002.atlarge.net (out002.atlarge.net [129.41.63.60])
	by ozlabs.org (Postfix) with ESMTP id 4DFB5DDEBF
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 Apr 2007 16:25:40 +1000 (EST)
Date: Mon, 16 Apr 2007 08:25:33 +0200
From: Domen Puncer <domen.puncer@telargo.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] icecube/lite5200b: wakeup from low-power support
Message-ID: <20070416062533.GH18236@moe.telargo.com>
References: <20070315103959.GA22215@moe.telargo.com>
	<20070315104411.GF22215@moe.telargo.com>
	<528646bc0703260908q7b018060v40db7e66aa81eaee@mail.gmail.com>
	<20070403084649.GA9163@nd47.coderock.org>
	<528646bc0704152145h44ff5f38wb6c4a1887261f6ed@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <528646bc0704152145h44ff5f38wb6c4a1887261f6ed@mail.gmail.com>
Cc: u-boot-users@lists.sourceforge.net, Stefan Roese <sr@denx.de>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 15/04/07 22:45 -0600, Grant Likely wrote:
> On 4/3/07, Domen Puncer <domen.puncer@telargo.com> wrote:
> >U-Boot part of Lite5200b low power mode support.
> >Puts SDRAM out of self-refresh and transfers control to
> >address saved at physical 0x0.
> 
> Looks good; almost there.  Only one thing missing... you need to add
> your "Signed-off-by" line.  :-)  See Documentation/SubmittingPatches
> in the Linux source tree.  (You can just reply to this message, and
> whoever merges the patch will add the line to the commit message)
> 
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> 
> Stefan; since there is no 5200 custodian, can you please pick up this
> patch once Domen sends a Signed-of-by replay?

I thought Signed-off-by's are Linux specific.


Signed-off-by: Domen Puncer <domen.puncer@telargo.com>


Thanks!

	Domen
