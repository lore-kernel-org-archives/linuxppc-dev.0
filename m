Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rTHy81HdyzDqh8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 15:19:28 +1000 (AEST)
Message-ID: <1465881567.17785.2.camel@ellerman.id.au>
Subject: Re: [FIX PATCH v2 0/2] Fix powerpc,numa: Fix memory_hotplug_max()
From: Michael Ellerman <mpe@ellerman.id.au>
To: bharata@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: david@gibson.dropbear.id.au, nfont@linux.vnet.ibm.com, aik@au1.ibm.com
Date: Tue, 14 Jun 2016 15:19:27 +1000
In-Reply-To: <20160614044651.GB5916@in.ibm.com>
References: <1463060055-24158-1-git-send-email-bharata@linux.vnet.ibm.com>
 <20160614044651.GB5916@in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-06-14 at 10:16 +0530, Bharata B Rao wrote:
> On Thu, May 12, 2016 at 07:04:13PM +0530, Bharata B Rao wrote:
> > This patchset fixes memory_hotplug_max() routine to return correct
> > value of maximum hotpluggable address.
> > 
> > In this version, whitespace fixes are separated into a different patch.
> > 
> > v2: https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg103342.html
> > 
> > Bharata B Rao (2):
> >   powerpc,numa: Fix whitespace in hot_add_drconf_memory_max()
> >   powerpc,numa: Fix memory_hotplug_max()
> > 
> >  arch/powerpc/mm/numa.c | 36 ++++++++++++++++++++++++++----------
> >  1 file changed, 26 insertions(+), 10 deletions(-)
> 
> Can this fix be considered for inclusion ? Should I be posting this against
> latest git now ?

No that's fine, it still applies cleanly.

Have you tested this on PowerVM ?

Has this always been broken, or did we break it in a particular commit? If the
latter can you tell me which commit.

Should we be sending this to stable?

cheers
