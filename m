Date: Wed, 21 Jul 2004 09:17:59 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Wolfgang Denk <wd@denx.de>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: can the 8xx patch configuration be made more comprehensible? 
In-Reply-To: <20040721125921.119FBC109F@atlas.denx.de>
Message-ID: <Pine.LNX.4.60.0407210914450.4882@dell.enoriver.com>
References: <20040721125921.119FBC109F@atlas.denx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 21 Jul 2004, Wolfgang Denk wrote:

> There are least 3 that are relevant here:
>
> - MPC850 microcode patch for relocating I2C/SPI parameters.
> - MPC860 microcode patch for relocating I2C/SPI parameters

   i can see that, in the 2.6 arch/ppc/8xx_io/micropatch.c file, there
is a test for the macro USE_IIC_PATCH.  now, back in wolfgang's 2.4.25
source tree, that macro is defined in include/asm-ppc/commproc.h
thusly:

#ifdef CONFIG_UCODE_PATCH
# define USE_IIC_PATCH
#else
# undef  USE_IIC_PATCH
#endif

   however, in the 2.6 tree, i see nowhere that that macro could
possibly be set, so it seems that any tests for USE_IIC_PATCH in the
2.6 tree are irrelevant, no?

rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
