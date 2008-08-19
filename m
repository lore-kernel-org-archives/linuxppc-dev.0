Return-Path: <dhlii@dlasys.net>
Received: from outbound-mail-112.bluehost.com (outbound-mail-112.bluehost.com
	[69.89.24.2]) by ozlabs.org (Postfix) with SMTP id 937CFDDF42
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Aug 2008 08:18:50 +1000 (EST)
Message-ID: <48AB4532.5030708@dlasys.net>
Date: Tue, 19 Aug 2008 18:12:02 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: John Linn <John.Linn@xilinx.com>
Subject: Re: [PATCH] Linux Device Driver for Xilinx LL TEMAC 10/100/1000
	EthernetNIC
References: <48AA938C.4060309@dlasys.net>
	<20080819201445.F39181468062@mail206-wa4.bigfish.com>
	<48AB2E58.2050307@dlasys.net>
	<20080819205148.82EAC50060@mail88-dub.bigfish.com>
	<48AB38AF.6010007@dlasys.net>
	<20080819214207.084C115A8055@mail165-dub.bigfish.com>
In-Reply-To: <20080819214207.084C115A8055@mail165-dub.bigfish.com>
Content-Type: text/plain; charset=US-ASCII
Cc: Ben Hutchings <bhutchings@solarflare.com>, netdev@vger.kernel.org,
	Stephen Neuendorffer <stephenn@xilinx.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

John Linn wrote:
>
> What about you getting all the review & testing done and then we
> (Xilinx) will add the OF support to the driver? 
>
> I doubt the powerpc mainline will take the driver without OF support. In
> fact, we had to remove the platform bus support from the last driver
> that we put into mainline for arch/powerpc.
>   

That is perfectly fine with me. i will try to pull the xilinx git tree
and see how much closer I can make the probe so that converting will be
easier.
>
>
> xilinx_lltemac is the preferred. 
>
> I don't think using xilinx_lltemac should cause problems.  Our Xilinx
> Git tree has a xilinx_lltemac subdir that contains the non-flat driver
> but that should be ok with your xilinx_lltemac.c file in the net
> directory.
>   
The next patch incarnation will have everything as xilinx_lltemac -
including the file as xilinx_lltemac.c

-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
