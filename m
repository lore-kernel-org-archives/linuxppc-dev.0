Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41x34w0cxqzF2Dd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 22:05:04 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [RESEND PATCH v2] powerpc/mce: Fix SLB rebolting during MCE
 recovery path.
In-Reply-To: <10dfea17-e98b-7a46-6dba-b222a6cf0c96@linux.vnet.ibm.com>
References: <153500619258.20614.8965724795728734200.stgit@jupiter.in.ibm.com>
 <87d0u9lgyt.fsf@concordia.ellerman.id.au>
 <10dfea17-e98b-7a46-6dba-b222a6cf0c96@linux.vnet.ibm.com>
Date: Thu, 23 Aug 2018 22:05:03 +1000
Message-ID: <871sapl24w.fsf@concordia.ellerman.id.au>
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

Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com> writes:

> On 08/23/2018 12:14 PM, Michael Ellerman wrote:
>> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> writes:
>> 
>>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>>
>>> With the powerpc next commit e7e81847478 (powerpc/mce: Fix SLB rebolting
>>> during MCE recovery path.),
>> 
>> That commit description is wrong, I'll fix it up.
>
> Ouch.. My bad.. :-(

To make it easier to get right, if you don't already, add these to your
~/.gitconfig:

[pretty]
	fixes = Fixes: %h (\"%s\")
	quote = %h (\"%s\")


And then you can do:

$ git log -1 --pretty=quote e7e81847478 
e7e81847478b ("powerpc/64s: move machine check SLB flushing to mm/slb.c")

$ git log -1 --pretty=fixes e7e81847478 
Fixes: e7e81847478b ("powerpc/64s: move machine check SLB flushing to mm/slb.c")


I then have a shell alias that pipes that into xclip, so I can just
paste it directly into the change log.

cheers
