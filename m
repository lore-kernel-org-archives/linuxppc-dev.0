Return-Path: <fweimer@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 419pBK0B2ZzDrbK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2018 01:08:41 +1000 (AEST)
Subject: Re: [PATCH v2 0/6] powerpc/pkeys: fixes to pkeys
To: Michael Ellerman <mpe@ellerman.id.au>, Ram Pai <linuxram@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, dave.hansen@intel.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, Ulrich.Weigand@de.ibm.com,
 luto@kernel.org, msuchanek@suse.de
References: <1528936144-6696-1-git-send-email-linuxram@us.ibm.com>
 <8812c879-5761-ef62-dd15-3ceef46d9653@redhat.com>
 <874lhzx84e.fsf@concordia.ellerman.id.au>
From: Florian Weimer <fweimer@redhat.com>
Message-ID: <34669c66-ce2f-e8a0-1d18-43086bad3faa@redhat.com>
Date: Wed, 20 Jun 2018 17:08:35 +0200
MIME-Version: 1.0
In-Reply-To: <874lhzx84e.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/19/2018 02:40 PM, Michael Ellerman wrote:
>> I tested the whole series with the new selftests, with the printamr.c
>> program I posted earlier, and the glibc test for pkey_alloc &c.  The
>> latter required some test fixes, but now passes as well.  As far as I
>> can tell, everything looks good now.
>>
>> Tested-By: Florian Weimer<fweimer@redhat.com>
> Thanks. I'll add that to each patch I guess, if you're happy with that?

Sure, but I only tested the whole series as a whole.

Thanks,
Florian
