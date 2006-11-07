Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/1]  PPC32 : Huge-page support for ppc440
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Roland Dreier <rdreier@cisco.com>
In-Reply-To: <ada1wogj5s0.fsf@cisco.com>
References: <454FC362.9070608@linux.vnet.ibm.com>
	<1162864834.3809.21.camel@zod.rchland.ibm.com>
	<1162866287.28571.392.camel@localhost.localdomain>
	<ada1wogj5s0.fsf@cisco.com>
Content-Type: text/plain
Date: Tue, 07 Nov 2006 14:45:22 +1100
Message-Id: <1162871122.28571.396.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org,
	Edi Shmueli <edi@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-11-06 at 19:26 -0800, Roland Dreier wrote:
>  > Also, while it's great to have somebody do this work, I doubt there is
>  > much interest in merging it for arch/ppc... 
> 
> On that subject, what's the latest on moving ppc4xx to arch/powerpc?
> At the kernel summit you told me to chill out and wait, but I'll
> repeat my offer to help out....

Well, I told you that Matt Porter was about to do it :-) Now I haven't
heard from him since. Feel free to jump in, just make sure you keep in
sync with Josh and Matt.

One of the reason waiting was a good idea too is that we didn't have a
proper mecanism for stuffing device-trees in zImage wrappers, which we 
have now.

Also, I've started doing some work around 4xx devices used on MMIO
platforms (like the Axon southbridge on Cell), and while doing that,
started moving EMAC to be an of_platform_device (or rather a set of them
since EMAC is made of multiple devices). (Based on initial work by
Shaun).

You can see some of that stuff in the big patch set I posted to the list
yesterday, though I already fixed various issues in some of those
patches, so I suppose I'll have to post a new one soon :)

Cheers,
Ben.
