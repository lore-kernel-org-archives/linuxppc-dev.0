Return-Path: <bunk@stusta.de>
Received: from mailhub.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by ozlabs.org (Postfix) with ESMTP id 828DCDDDF4
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Aug 2007 05:06:33 +1000 (EST)
Date: Wed, 1 Aug 2007 21:06:11 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [2.6 patch] ppc .gitignore update
Message-ID: <20070801190611.GQ3972@stusta.de>
References: <20070801133056.GP3972@stusta.de>
	<fa686aa40708010653v7e1fb909gb03eb1d4754359bf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <fa686aa40708010653v7e1fb909gb03eb1d4754359bf@mail.gmail.com>
Cc: Rutger Nijlunsing <rutger@nospam.com>, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 01, 2007 at 07:53:28AM -0600, Grant Likely wrote:
> On 8/1/07, Adrian Bunk <bunk@stusta.de> wrote:
> > arch/ppc/.gitignore shouldn't exclude arch/ppc/boot/include
> >
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> >
> > ---
> > --- /dev/null   2006-09-19 00:45:31.000000000 +0200
> > +++ linux-2.6.23-rc1-mm2/arch/ppc/boot/.gitignore       2007-08-01 15:18:33.000000000 +0200
> > @@ -0,0 +1 @@
> > +!include
> 
> I don't think this is the best way to go about it; rather,
> arch/ppc/.gitignore should be made more specific like so:
> 
> diff --git a/arch/ppc/.gitignore b/arch/ppc/.gitignore
> index a1a869c..1e79a0a 100644
> --- a/arch/ppc/.gitignore
> +++ b/arch/ppc/.gitignore
> @@ -1 +1 @@
> -include
> +/include

Thanks, that's obviously better than my patch.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
