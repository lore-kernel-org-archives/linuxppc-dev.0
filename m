Return-Path: <dgibson@ozlabs.org>
Date: Tue, 18 Nov 2008 11:17:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Michael Barkowski <michael.barkowski@freescale.com>
Subject: Re: [PATCH] mpc832x_rdb: fix swapped ethernet ids
Message-ID: <20081118001740.GA26336@yookeroo.seuss>
References: <491C4544.7020707@freescale.com>
	<20081113234507.GB32024@yookeroo.seuss>
	<491D9643.4010204@freescale.com>
	<20081115022637.GC6629@yookeroo.seuss>
	<49219BC4.7050803@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49219BC4.7050803@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Nov 17, 2008 at 11:28:52AM -0500, Michael Barkowski wrote:
> David Gibson wrote:
>> On Fri, Nov 14, 2008 at 10:16:19AM -0500, Michael Barkowski wrote:
>>> David Gibson wrote:
>>>> On Thu, Nov 13, 2008 at 10:18:28AM -0500, Michael Barkowski wrote:
>>>>> ethernet0 (called FSL UEC0 in U-Boot) should be enet1 (UCC3/eth1), and
>>>>> ethernet1 should be enet0 (UCC2/eth0), to be consistent with U-Boot so
>>>>> that the interfaces do not swap addresses when control passes from
>>>>> U-Boot to the kernel.
>>>> Um.. why is just swapping the aliases, rather than the enet labels the
>>>> right approach here?
>>> Kim suggested it was better to localize the port ordering as a
>>> property of the board rather than that of the QE, and I agreed.
>>
>> And the enet0/enet1 names that appear in the labels come from the QE
>> documentation?
>>
> No.. but don't you think the UCC2, UCC3 names, which *do* come from
> the QE documentation, should match their labels in numeric ordering?
> Aren't the aliases just machine-specific shortcuts for the
> bootloader?

Ok, that's reasonable (although personally I would have thought it
would make more sense for the labels to be based on the documentation
terms, so UCC2, UCC3 etc., as we do on 4xx).

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
