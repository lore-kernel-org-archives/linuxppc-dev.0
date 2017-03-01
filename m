Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vYXL36GDlzDqLd
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Mar 2017 10:52:11 +1100 (AEDT)
Message-ID: <1488412325.16871.1.camel@russell.cc>
Subject: Re: [RESEND-RFC v2 1/3] powerpc/eeh: Refactor
 eeh_pe_update_time_stamp() to update freeze_count
From: Russell Currey <ruscur@russell.cc>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, "Guilherme G. Piccoli"
 <gpiccoli@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>, Frederic Barrat
 <fbarrat@linux.vnet.ibm.com>, Gavin Shan <gwshan@linux.vnet.ibm.com>, Ian
 Munsie <imunsie@au1.ibm.com>, Andrew Donnellan
 <andrew.donnellan@au1.ibm.com>, Christophe Lombard
 <christophe_lombard@fr.ibm.com>, Greg Kurz <gkurz@linux.vnet.ibm.com>
Date: Thu, 02 Mar 2017 10:52:05 +1100
In-Reply-To: <87lgsp0xpt.fsf@vajain21.in.ibm.com>
References: <20170301112452.15798-1-vaibhav@linux.vnet.ibm.com>
 <20170301112452.15798-2-vaibhav@linux.vnet.ibm.com>
 <e288dd57-df0d-44c1-2867-ce1d1386ad1f@linux.vnet.ibm.com>
 <87lgsp0xpt.fsf@vajain21.in.ibm.com>
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

On Wed, 2017-03-01 at 21:56 +0530, Vaibhav Jain wrote:
> Thanks for reviewing the patch !!
> 
> "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com> writes:
> > 
> > Not sure why, but many of the words in commit message are missing their
> > first letter. See, for example:
> > reeze_count,  roze,  eports,  ermanently
> 
> Thanks for pointing this out. Will fix this in the subsequent patch
> revision.
> 
> > >  /**
> > > - * eeh_pe_update_time_stamp - Update PE's frozen time stamp
> > > + * eeh_pe_update_freeze_counter - Update PE's frozen time stamp
> > > + * and freeze counter
> > >   * @pe: EEH PE
> > >   *
> > > - * We have time stamp for each PE to trace its time of getting
> > > - * frozen in last hour. The function should be called to update
> > > - * the time stamp on first error of the specific PE. On the other
> > > - * handle, we needn't account for errors happened in last hour.
> > 
> > s/handle/hand? "On the other hand..."
> 
> Thats part of original comment which this patch is replacing.

It's still worth fixing. Maybe "On the other hand, we don't need to account for
errors that happened in the last hour."

I really need to get around to fixing up a lot of these old comments...
