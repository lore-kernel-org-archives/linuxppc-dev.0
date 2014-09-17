Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D9C7E1A00FF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Sep 2014 13:31:06 +1000 (EST)
Message-ID: <1410924666.1586.2.camel@concordia>
Subject: Re: [PATCH 1/4] powerpc: Make a bunch of things static
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Wed, 17 Sep 2014 13:31:06 +1000
In-Reply-To: <54183371.7020901@linux.vnet.ibm.com>
References: <1408488921-19187-1-git-send-email-anton@samba.org>
 <54183371.7020901@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-09-16 at 07:56 -0500, Nathan Fontenot wrote:
> On 08/19/2014 05:55 PM, Anton Blanchard wrote:
> > diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
> > index a2450b8..d37ba4f 100644
> > --- a/arch/powerpc/platforms/pseries/dlpar.c
> > +++ b/arch/powerpc/platforms/pseries/dlpar.c
> > @@ -334,7 +334,7 @@ int dlpar_acquire_drc(u32 drc_index)
> >  	return 0;
> >  }
> >  
> > -int dlpar_release_drc(u32 drc_index)
> > +static int dlpar_release_drc(u32 drc_index)
> >  {
> >  	int dr_status, rc;
> 
> Anton, if you're going to do a v2 of these patches you could leave out
> the routines in dlpar.c. I just sent a patch out that exports these two
> functions for memory hotplug updates.

Yep I've dropped those hunks in my tree.

ps. Please trim your replies :)

cheers
