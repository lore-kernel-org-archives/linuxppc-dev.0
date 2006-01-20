Return-Path: <bunk@stusta.de>
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by ozlabs.org (Postfix) with SMTP id A72B968A3D
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jan 2006 06:04:19 +1100 (EST)
Date: Fri, 20 Jan 2006 20:04:15 +0100
From: Adrian Bunk <bunk@stusta.de>
To: benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [Alsa-devel] RFC: OSS driver removal,
	a slightly different approach
Message-ID: <20060120190415.GM19398@stusta.de>
References: <20060119174600.GT19398@stusta.de>
	<20060120115443.GA16582@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060120115443.GA16582@palantir8>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jan 20, 2006 at 11:54:43AM +0000, Martin Habets wrote:

> It seems to me we can already get rid of sound/oss/dmasound now.
> I cannot find anything refering to it anymore, and the ALSA powermac
> driver is being maintained.

You are correct that I forgot to add the dmasound drivers to my list, 
but I don't think we can get rid of all of them since I doubt the ALSA 
powermac driver was able to drive m68k hardware.

Can someone from the ppc developers drop me a small note whether 
SND_POWERMAC completely replaces DMASOUND_PMAC?

> Martin

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
