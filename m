Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrJtq4JGtzDqFK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 14:07:31 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] linuxppc/devtree: Parse new DRC mem/cpu/dev device tree
 elements
In-Reply-To: <5786A793.2000504@linux.vnet.ibm.com>
References: <31f35f7c-3129-6bcc-1a0f-37e78aaa2e61@linux.vnet.ibm.com>
 <5786A793.2000504@linux.vnet.ibm.com>
Date: Fri, 15 Jul 2016 14:07:31 +1000
Message-ID: <87h9brbl30.fsf@@concordia.ellerman.id.au>
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

Nathan Fontenot <nfont@linux.vnet.ibm.com> writes:

> On 06/30/2016 04:44 PM, Michael Bringmann wrote:
>> Several properties in the DRC device tree format are replaced by
>> more compact representations to allow, for example, for the encoding
>> of vast amounts of memory, and or reduced duplication of information
>> in related data structures.
...
>
> A thought, this is a big patch. Perhaps it should be split into multiple
> patches; setting the arch bit, prom updates, numa updates, hotplug
> updates...

Please.

cheers
