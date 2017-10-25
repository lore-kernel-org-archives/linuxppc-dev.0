Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yMPsw1fLFzDqkp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Oct 2017 20:27:00 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ram Pai <linuxram@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com
Subject: Re: [PATCH 08/25] powerpc: sys_pkey_alloc() and sys_pkey_free()
 system calls
In-Reply-To: <20171024183450.GL5454@ram.oc3035372033.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-17-git-send-email-linuxram@us.ibm.com>
 <871sls4ke8.fsf@concordia.ellerman.id.au>
 <20171024183450.GL5454@ram.oc3035372033.ibm.com>
Date: Wed, 25 Oct 2017 11:26:50 +0200
Message-ID: <87a80f1sth.fsf@concordia.ellerman.id.au>
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

Ram Pai <linuxram@us.ibm.com> writes:

> On Tue, Oct 24, 2017 at 05:48:15PM +0200, Michael Ellerman wrote:
>> Ram Pai <linuxram@us.ibm.com> writes:
>> 
>> > Finally this patch provides the ability for a process to
>> > allocate and free a protection key.
>> 
>> This must be the last patch in the series.
>> 
>> We don't want to expose a half working interface to userspace.
>
> The way the patch series is organized -- this patch; even-though
> introduces the syscall, the syscall will fail because the pkey subsystem
> is enabled only by the last patch. Till than the code exists , but does
> a great job of failing with an appropriate return code.

See my previous mail :)

Please don't add the syscall until it can work.

cheers
