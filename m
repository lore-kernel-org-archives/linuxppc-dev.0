Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zX4VL1gZCzDr2Q
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Feb 2018 13:55:22 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ingo Molnar <mingo@kernel.org>, Ram Pai <linuxram@us.ibm.com>
Cc: mingo@redhat.com, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, dave.hansen@intel.com, benh@kernel.crashing.org,
 paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, corbet@lwn.net,
 arnd@arndb.de, fweimer@redhat.com, msuchanek@suse.com
Subject: Re: [PATCH v11 0/3] mm, x86,
 powerpc: Enhancements to Memory Protection Keys.
In-Reply-To: <20180131070711.pad45qmnougnh4vf@gmail.com>
References: <1517341452-11924-1-git-send-email-linuxram@us.ibm.com>
 <20180131070711.pad45qmnougnh4vf@gmail.com>
Date: Thu, 01 Feb 2018 13:55:21 +1100
Message-ID: <87lggde7vq.fsf@concordia.ellerman.id.au>
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

Ingo Molnar <mingo@kernel.org> writes:

> * Ram Pai <linuxram@us.ibm.com> wrote:
>
>> This patch series provides arch-neutral enhancements to
>> enable memory-keys on new architecutes, and the corresponding
>> changes in x86 and powerpc specific code to support that.
>> 
>> a) Provides ability to support upto 32 keys.  PowerPC
>> 	can handle 32 keys and hence needs this.
>> 
>> b) Arch-neutral code; and not the arch-specific code,
>>    determines the format of the string, that displays the key
>>    for each vma in smaps.
>> 
>> PowerPC implementation of memory-keys is now in powerpc/next tree.
>> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?h=next&id=92e3da3cf193fd27996909956c12a23c0333da44
>
> All three patches look sane to me. If you would like to carry these generic bits 
> in the PowerPC tree as well then:
>
>   Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thanks.

I'll put them in powerpc next and probably send to Linus next week in a
2nd pull request for 4.16.

cheers
