Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wDsvy0SJjzDqH6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Apr 2017 22:05:34 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Cc: linuxppc-dev@ozlabs.org, aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH v6 10/19] powerpc/mm/hash: Use context ids 1-4 for the
 kernel
In-Reply-To: <20170428125723.58860091@kitsune.suse.cz>
References: <1490875447-4016-1-git-send-email-mpe@ellerman.id.au>
 <1490875447-4016-10-git-send-email-mpe@ellerman.id.au>
 <20170428125723.58860091@kitsune.suse.cz>
Date: Fri, 28 Apr 2017 22:05:32 +1000
Message-ID: <87efwcu48j.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michal Such=C3=A1nek <msuchanek@suse.de> writes:
> Hello,
>
> just a nit:
>
> On Thu, 30 Mar 2017 23:03:58 +1100
> Michael Ellerman <mpe@ellerman.id.au> wrote:
>> + * For kernel space, we use context ids 1-5 to map address as below:
>
> This appears wrong.

>>  	/*
>> -	 * kernel take the top 4 context from the available range
>> +	 * For kernel space, we use context ids 1-4 to map the
>
> and this appears right - or at least consistent with the commit
> message ... and the rest of the comment.

Yep thanks.

Patch on its way.

cheers
