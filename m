Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DEFEE1A0FFD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jul 2015 15:47:57 +1000 (AEST)
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 182CC1402AB
 for <linuxppc-dev@ozlabs.org>; Thu,  2 Jul 2015 15:47:56 +1000 (AEST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Thu, 2 Jul 2015 11:17:53 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 6FD64E0044
 for <linuxppc-dev@ozlabs.org>; Thu,  2 Jul 2015 11:21:35 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t625lpfO3867124
 for <linuxppc-dev@ozlabs.org>; Thu, 2 Jul 2015 11:17:51 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t624dX6Y008104
 for <linuxppc-dev@ozlabs.org>; Thu, 2 Jul 2015 10:09:33 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, thuth@redhat.com, aik@ozlabs.ru, dvaleev@suse.com
Subject: Re: [PATCH SLOF v3 3/5] disk-label: rename confusing "block" word
In-Reply-To: <20150701073238.GA8068@gate.crashing.org>
References: <1435662081-4293-1-git-send-email-nikunj@linux.vnet.ibm.com>
 <1435662081-4293-4-git-send-email-nikunj@linux.vnet.ibm.com>
 <20150701073238.GA8068@gate.crashing.org>
Date: Thu, 02 Jul 2015 11:17:49 +0530
Message-ID: <876163f6uy.fsf@linux.vnet.ibm.com>
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


Hi Segher,

Segher Boessenkool <segher@kernel.crashing.org> writes:
> On Tue, Jun 30, 2015 at 04:31:19PM +0530, Nikunj A Dadhania wrote:
>> "block" word is not a block number, actually its an allocated host
>> address.  Rename it to disk-buf along with a associated
>> size(disk-buf-size=4096) for using during allocation/free.
>> 
>> Also renaming the helper routine read-sector to read-disk-buf. This
>> routine assumes the address to be disk-buf and only takes sector number
>> as argument.
>
> This isn't what I suggested, and I think it is a terrible idea.

The comment was against the "has-fat-filesystem". As the complete
disk-label.fs had that same assumption, I went ahead and renamed "block"
across the file.

Are you suggesting to drop complete patch or just the rename of
"read-sector" ?

> Just FWIW :-)

Regards
Nikunj
