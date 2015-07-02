Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BF63B1A0FFE
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jul 2015 20:15:08 +1000 (AEST)
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 939821401EF
 for <linuxppc-dev@ozlabs.org>; Thu,  2 Jul 2015 20:15:08 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Thu, 2 Jul 2015 20:15:02 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id CDA242BB0040
 for <linuxppc-dev@ozlabs.org>; Thu,  2 Jul 2015 20:15:04 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t62AEsKL38338744
 for <linuxppc-dev@ozlabs.org>; Thu, 2 Jul 2015 20:15:02 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t62AEWRD031513
 for <linuxppc-dev@ozlabs.org>; Thu, 2 Jul 2015 20:14:32 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, thuth@redhat.com, aik@ozlabs.ru, dvaleev@suse.com
Subject: Re: [PATCH SLOF v3 3/5] disk-label: rename confusing "block" word
In-Reply-To: <20150702100416.GA4392@gate.crashing.org>
References: <1435662081-4293-1-git-send-email-nikunj@linux.vnet.ibm.com>
 <1435662081-4293-4-git-send-email-nikunj@linux.vnet.ibm.com>
 <20150701073238.GA8068@gate.crashing.org> <876163f6uy.fsf@linux.vnet.ibm.com>
 <20150702100416.GA4392@gate.crashing.org>
Date: Thu, 02 Jul 2015 15:44:13 +0530
Message-ID: <87twtmeuiy.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Segher Boessenkool <segher@kernel.crashing.org> writes:

> On Thu, Jul 02, 2015 at 11:17:49AM +0530, Nikunj A Dadhania wrote:
>> >> "block" word is not a block number, actually its an allocated host
>> >> address.  Rename it to disk-buf along with a associated
>> >> size(disk-buf-size=4096) for using during allocation/free.
>> >> 
>> >> Also renaming the helper routine read-sector to read-disk-buf. This
>> >> routine assumes the address to be disk-buf and only takes sector number
>> >> as argument.
>> >
>> > This isn't what I suggested, and I think it is a terrible idea.
>> 
>> The comment was against the "has-fat-filesystem". As the complete
>> disk-label.fs had that same assumption, I went ahead and renamed "block"
>> across the file.
>
> No, I said that "block" in that stack comment was misleading.  Nothing more.
>
> Since the word "block" is used all over the file (as your patch size shows),
> a short name is much better than a longer name, esp. if that shorter name
> actually is more expressive.

Sure, will resend dropping this patch.

Regards,
Nikunj
