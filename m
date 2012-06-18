Return-Path: <mchehab@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 76696B707C
 for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2012 06:35:18 +1000 (EST)
Message-ID: <4FDF90FE.1050809@redhat.com>
Date: Mon, 18 Jun 2012 17:35:10 -0300
From: Mauro Carvalho Chehab <mchehab@redhat.com>
MIME-Version: 1.0
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: Build regressions/improvements in v3.5-rc3
References: <1339962373-3224-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdVfLjgrtWoPpvbLf12+=ApE6W9dNcweqD-_2Benr-D7NQ@mail.gmail.com>
 <20120618152758.3a0a28c7f68615e9e2599ee3@freescale.com>
In-Reply-To: <20120618152758.3a0a28c7f68615e9e2599ee3@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org,
 Chris Zankel <chris@zankel.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em 18-06-2012 17:27, Kim Phillips escreveu:
> On Sun, 17 Jun 2012 21:56:59 +0200
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> 
>>    + drivers/edac/mpc85xx_edac.c: error: too few arguments to function
>> 'edac_mc_alloc':  => 983:90
>>
>> powerpc-randconfig
> 
> fixed in linux-next commit b9bc5dd, should have been upstreamed by
> now [1] - Mauro?

Just sent it a few mins ago. I was waiting for Linus to return back 
from his trip.

Regards,
Mauro

> 
> Kim
> 
> [1] http://marc.info/?l=linux-edac&m=133942731507920&w=2
> 
