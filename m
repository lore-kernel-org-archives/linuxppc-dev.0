Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdwzZ4tjDzDrWL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Aug 2017 19:36:58 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, apopple@au1.ibm.com, hbabu@us.ibm.com,
 oohall@gmail.com, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 07/12] powerpc/vas: Define vas_win_paste_addr()
In-Reply-To: <1503556688-15412-8-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1503556688-15412-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1503556688-15412-8-git-send-email-sukadev@linux.vnet.ibm.com>
Date: Fri, 25 Aug 2017 19:36:57 +1000
Message-ID: <8760dcugxy.fsf@concordia.ellerman.id.au>
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

Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:

> Define an interface that the NX drivers can use to find the physical
> paste address of a send window. This interface is expected to be used
> with the mmap() operation of the NX driver's device. i.e the user space
> process can use driver's mmap() operation to map the send window's paste
> address into their address space and then use copy and paste instructions
> to submit the CRBs to the NX engine.
>
> Note that kernel drivers will use vas_paste_crb() directly and don't need
> this interface.

AFAICS this is not used. And if it was that would be a problem because
there are implications in letting userspace do paste, so can you drop
this from the series for now.

cheers
