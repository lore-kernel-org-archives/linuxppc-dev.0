Return-Path: <gkurz@linux.vnet.ibm.com>
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0AEC31A09FE
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 19:09:10 +1100 (AEDT)
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gkurz@linux.vnet.ibm.com>;
 Thu, 4 Dec 2014 08:09:06 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6CF3E219005C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 08:08:36 +0000 (GMT)
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
 [9.149.37.247])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB48944a26738690
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Dec 2014 08:09:04 GMT
Received: from d06av12.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB4893qi017153
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Dec 2014 01:09:04 -0700
Date: Thu, 4 Dec 2014 09:09:01 +0100
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc: drop useless warning in eeh_init()
Message-ID: <20141204090901.126c1d64@bahia.local>
In-Reply-To: <1417653165.9123.3.camel@concordia>
References: <20141125161006.1995.31789.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
 <20141125222846.GA7662@shangw>
 <20141203152046.5c109d1f@bahia.local>
 <20141203221422.GA4927@shangw> <1417653165.9123.3.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 04 Dec 2014 11:32:45 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> On Thu, 2014-12-04 at 09:14 +1100, Gavin Shan wrote:
> > On Wed, Dec 03, 2014 at 03:20:46PM +0100, Greg Kurz wrote:
> > >On Wed, 26 Nov 2014 09:28:47 +1100
> > >Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
> > >> On Tue, Nov 25, 2014 at 05:10:06PM +0100, Greg Kurz wrote:
> > >> >This is what we get in dmesg when booting a pseries guest and
> > >> >the hypervisor doesn't provide EEH support.
> > >
> > >Ping ?
> > 
> > It's already in Michael's git tree.
> 
> Indeed.
> 
> It's also marked as "Under Review" in patchwork, which basically means I've
> seen it and it's on its way into my tree unless you hear otherwise.
> 
> http://patchwork.ozlabs.org/patch/414753/
> 
> cheers
> 
> 

Sorry for the noise, I'll check next  time... :\

--
G
