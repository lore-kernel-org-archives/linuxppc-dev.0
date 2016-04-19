Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqJQ82PszzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 07:42:24 +1000 (AEST)
Received: from mail-pa0-x232.google.com (mail-pa0-x232.google.com
 [IPv6:2607:f8b0:400e:c03::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qqJQ75S4tz9t8k
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Apr 2016 07:42:23 +1000 (AEST)
Received: by mail-pa0-x232.google.com with SMTP id fs9so10510306pac.2
 for <linuxppc-dev@ozlabs.org>; Tue, 19 Apr 2016 14:42:23 -0700 (PDT)
Subject: Re: [PATCH 0/5] Live patching for powerpc
To: Jiri Kosina <jikos@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <1460552003-15409-1-git-send-email-mpe@ellerman.id.au>
 <alpine.LNX.2.00.1604131457180.16586@pobox.suse.cz>
 <alpine.LNX.2.00.1604131508500.27368@cbobk.fhfr.pm>
 <1460616590.2754.6.camel@ellerman.id.au>
 <alpine.LNX.2.00.1604151136320.27368@cbobk.fhfr.pm>
Cc: Miroslav Benes <mbenes@suse.cz>, linuxppc-dev@ozlabs.org, duwe@lst.de,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, pmladek@suse.com, jeyu@redhat.com,
 live-patching@vger.kernel.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <5716A62F.6040900@gmail.com>
Date: Wed, 20 Apr 2016 07:42:07 +1000
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.00.1604151136320.27368@cbobk.fhfr.pm>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 16/04/16 01:07, Jiri Kosina wrote:
> On Thu, 14 Apr 2016, Michael Ellerman wrote:
> 
>> Topic branch here:
>>
>>   https://git.kernel.org/cgit/linux/kernel/git/powerpc/linux.git/log/?h=topic/livepatch
>>
>> I will merge that before Monday (my time) if I don't hear any objections.
> 
> I've now pulled this into livepatching.git#for-4.7/livepatching-ppc64 and 
> merged that branch into for-next as well.
> 
> That branch already contains all the relocation changes queued for 4.7, so 
> as much testing of the merged result as possible on ppc64 would be 
> appreciated.
Thanks, do we have a summary of what the relocation changes look like?

Balbir Singh.
