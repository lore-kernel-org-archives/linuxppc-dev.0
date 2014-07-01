Return-Path: <hare@suse.de>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 046901A0044
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Jul 2014 15:58:02 +1000 (EST)
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 881E11400E1
 for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2014 15:58:01 +1000 (EST)
Message-ID: <53B24DE3.9050108@suse.de>
Date: Tue, 01 Jul 2014 07:57:55 +0200
From: Hannes Reinecke <hare@suse.de>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Regression in 3.15 on POWER8 with multipath SCSI
References: <20140630103058.GA17747@iris.ozlabs.ibm.com>
 <53B1416D.8020305@suse.de> <20140630110202.GB17747@iris.ozlabs.ibm.com>
 <53B14B78.4010500@suse.de> <20140630212801.GB20819@iris.ozlabs.ibm.com>
In-Reply-To: <20140630212801.GB20819@iris.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Vladimir Davydov <vdavydov@parallels.com>,
 Kay Sievers <kay.sievers@vrfy.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org, dm-devel@redhat.com,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/30/2014 11:28 PM, Paul Mackerras wrote:
> On Mon, Jun 30, 2014 at 01:35:20PM +0200, Hannes Reinecke wrote:
>> On 06/30/2014 01:02 PM, Paul Mackerras wrote:
[ .. ]
>>>
>>> No, I'm not using LVM, and in fact I deleted all the physical volumes
>>> that were on any of the disks (they were installations of other
>>> distros), so there are no physical or logical volumes anywhere on any
>>> disk.  I haven't tried disabling the LVM service completely, though.
>>> What would it mean if disabling the LVM service made a difference?
>>>
>> Yes. LVM integration with systemd is a science unto itself.
>> I'm reasonably confident with multipath, but not LVM.
>> Plus the fact the the LVM service apparently is waiting for something sort
>> of points into that direction.
>>
>> So please do disable the lvm service.
>
> I disabled the LVM service, and it's still bad.  Unmodified 3.15
> booted successfully in only 18 out of 50 attempts with LVM disabled.
>
> So it's not LVM.  In any case LVM was fine with a 3.14 kernel.
>
Right, that was just a cross-check to eliminate any variables.

I'll be checking here at my end.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: J. Hawn, J. Guild, F. Imendörffer, HRB 16746 (AG Nürnberg)
