Return-Path: <nacc@us.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id CDD85B6F8C
 for <linuxppc-dev@ozlabs.org>; Thu,  3 Nov 2011 05:31:38 +1100 (EST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nacc@us.ibm.com>;
 Wed, 2 Nov 2011 12:31:27 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pA2IV15l068170
 for <linuxppc-dev@ozlabs.org>; Wed, 2 Nov 2011 12:31:13 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pA2IUxSD002067
 for <linuxppc-dev@ozlabs.org>; Wed, 2 Nov 2011 12:31:00 -0600
Date: Wed, 2 Nov 2011 11:30:55 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Ryan Wang <openspace.wang@gmail.com>
Subject: Re: What does rmo/tce stand for in powerpc?
Message-ID: <20111102183055.GK24610@us.ibm.com>
References: <CAPxxNQnhXaKJ5ve-=0qwChuuvDj_027RM2pSD43DEf6BZbaHDA@mail.gmail.com>
 <20111101172531.GG16267@us.ibm.com>
 <CAPxxNQ=TkMFhzBeLi9bt5Fo7gygoM2V61EHYRzKqcMetaG2qnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAPxxNQ=TkMFhzBeLi9bt5Fo7gygoM2V61EHYRzKqcMetaG2qnQ@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02.11.2011 [19:17:20 +0800], Ryan Wang wrote:
> 2011/11/2 Nishanth Aravamudan <nacc@us.ibm.com>
> 
> > Hi Ryan,
> >
> > On 01.11.2011 [14:25:43 +0800], Ryan Wang wrote:
> > > Hi,
> > >
> > > In kernel source comments, I saw the words:
> > > ''
> > >
> > > alloc_top is set to the top of RMO, eventually shrink down if the
> > > <http://lxr.linux.no/linux+*/arch/powerpc/kernel/prom_init.c#L972>TCEs
> > > overlap
> > >
> > > ''
> > >
> > > I wonder what does RMO mean, and TCE?
> >
> > RMO = Real Mode Offset -- deprecated in terms of Real Mode Area in PAPR.
> >
> > TCE = Translation Control Entry
> >
> > You should be able to find descriptions of both in PAPR.
> >
> 
> Thanks Nish!
> 
> But I searched <Power.orgTM Standard for Embedded Power ArchitectureTM
> Platform Requirements> and failed to found the concept RMO or Real Mode
> Offset.
> 
> Will you please give me some hints to the docs??Thanks,

Section 14.1.1 Real Mode Accesses in PAPR 2.4

Thanks,
Nish

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
