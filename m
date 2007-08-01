Return-Path: <dgibson@ozlabs.org>
Date: Wed, 1 Aug 2007 15:05:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 5/6] PowerPC 440EPx: Sequoia board support
Message-ID: <20070801050542.GJ31391@localhost.localdomain>
References: <20070730151628.GA5100@ru.mvista.com>
	<20070801021541.GE31391@localhost.localdomain>
	<1a27a299b62c4b3a1a1f8fe8912e8e40@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1a27a299b62c4b3a1a1f8fe8912e8e40@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 01, 2007 at 07:01:17AM +0200, Segher Boessenkool wrote:
> >> +	{ /* 440EPX  - without Security/Kasumi  */
> >> +		.pvr_mask		= 0xf0000fff,
> >> +		.pvr_value		= 0x200008D4,
> >> +		.cpu_name		= "440EPX - no Security/Kasumi",
> >> +		.cpu_features		= CPU_FTRS_44X,
> >> +		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU, /* 
> >> 440EPX has an FPU */
> >> +		.icache_bsize		= 32,
> >> +		.dcache_bsize		= 32,
> >> +	},
> >
> > Since the with/without Security/Kasumi versions have no differences in
> > their cputable entry other than the PVR, couldn't you just remove the
> > relevant PVR bit from the mask and use a single entry?
> 
> And get rid of the stupid "has an FPU" comment at the same time
> please :-)

Actually that comment may be worthwhile if expanded a little.  I think
the point is that 440EPx *unlike most other 4xx chips* has an FPU.  So
the point of the comment is not explaining the feature bit, which is
obvious, but as a "no, really, it does".

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
