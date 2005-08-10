Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id D258867F05
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Aug 2005 01:38:07 +1000 (EST)
Date: Wed, 10 Aug 2005 10:37:50 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: "Vikas Aggarwal" <va824363@albany.edu>
Message-Id: <20050810103750.253a2b74.kim.phillips@freescale.com>
In-Reply-To: <53521.198.22.236.230.1123620724.squirrel@198.22.236.230>
References: <32704.198.22.236.230.1122651627.squirrel@198.22.236.230>
	<20050729153323.3f2c62ad.kim.phillips@freescale.com>
	<32798.24.92.61.26.1122694772.squirrel@24.92.61.26>
	<20050730183217.3310585b.kim.phillips@freescale.com>
	<33216.24.92.61.26.1122857296.squirrel@24.92.61.26>
	<20050801123728.62764c7e.kim.phillips@freescale.com>
	<53547.198.22.236.230.1122997515.squirrel@198.22.236.230>
	<20050803114749.739ae51e.kim.phillips@freescale.com>
	<30177.198.22.236.230.1123094006.squirrel@198.22.236.230>
	<20050803153540.3530e114.kim.phillips@freescale.com>
	<53521.198.22.236.230.1123620724.squirrel@198.22.236.230>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: mpc8248  SEC -- interrupt handler 'is' invoked
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 9 Aug 2005 16:52:04 -0400 (EDT)
"Vikas Aggarwal" <va824363@albany.edu> wrote:

> The address returned by kmalloc=0x009ffc5c  is 4 byte aligned.
> Are u advicing that dma_map_single() should return 8 byte aligned ,
> becuase thats what gets written into the Data-Paclet_descriptor later.
> 
I wouldn't worry about alignment as much as the register write trace and checking the System Interface Unit and individual eu status registers.

-- 
Kim
