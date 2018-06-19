Return-Path: <fweimer@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4197qR1355zF0jD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 23:20:02 +1000 (AEST)
Subject: Re: [PATCH v2 6/6] powerpc/pkeys: Deny read/write/execute by default
To: Michael Ellerman <mpe@ellerman.id.au>, Ram Pai <linuxram@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, dave.hansen@intel.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, Ulrich.Weigand@de.ibm.com,
 luto@kernel.org, msuchanek@suse.de
References: <1528936144-6696-1-git-send-email-linuxram@us.ibm.com>
 <1528936144-6696-7-git-send-email-linuxram@us.ibm.com>
 <87602fx84g.fsf@concordia.ellerman.id.au>
From: Florian Weimer <fweimer@redhat.com>
Message-ID: <e1c0ff70-6f47-67cc-84da-47a921517766@redhat.com>
Date: Tue, 19 Jun 2018 15:19:56 +0200
MIME-Version: 1.0
In-Reply-To: <87602fx84g.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/19/2018 02:39 PM, Michael Ellerman wrote:
> Ram Pai <linuxram@us.ibm.com> writes:
>> Deny all permissions on all keys, with some exceptions.  pkey-0 must
>> allow all permissions, or else everything comes to a screaching halt.
>> Execute-only key must allow execute permission.
> 
> Another ABI change.
> 
> Are we calling this a bug fix?

Yes.  Note that the default is configurable on x86 (default is deny), so 
it's not really an ABI change as such IMHO.

Thanks,
Florian
