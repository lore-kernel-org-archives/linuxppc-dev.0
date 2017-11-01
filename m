Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yRbKH3JkLzDr1w
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Nov 2017 15:46:43 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ram Pai <linuxram@us.ibm.com>, Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH 00/16] Remove hash page table slot tracking from linux PTE
In-Reply-To: <20171030005106.GD5587@ram.oc3035372033.ibm.com>
References: <20171027040833.3644-1-aneesh.kumar@linux.vnet.ibm.com>
 <20171027043430.GA27483@fergus.ozlabs.ibm.com>
 <adf2d270-29df-701f-206e-0d8a35084e47@linux.vnet.ibm.com>
 <20171028223532.GA5587@ram.oc3035372033.ibm.com>
 <20171029220417.GA3317@fergus.ozlabs.ibm.com>
 <20171030005106.GD5587@ram.oc3035372033.ibm.com>
Date: Wed, 01 Nov 2017 15:46:39 +1100
Message-ID: <878tfq8v2o.fsf@concordia.ellerman.id.au>
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

> On Mon, Oct 30, 2017 at 09:04:17AM +1100, Paul Mackerras wrote:
>> On Sat, Oct 28, 2017 at 03:35:32PM -0700, Ram Pai wrote:
>> > 
>> > I like the idea of not tracking the slots at all. It is something the
>> > guest should not be knowing or tracking.
>> 
>> Why do you say that?
>
> 'slot' is a internal mechanism used by the hash table to accelerate
> mapping an address to a hash-page.  If the hash-table implementation
> choose to use a different mechanism to accelerate the mapping, it can't
> because that mechanism is baked into the logic of all the consumers.

The slots are defined in the architecture, so it's entirely fine for
guests to track them.

cheers
