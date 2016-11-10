Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tDlyv0ycnzDvkR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 12:37:11 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Reza Arbab <arbab@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 devicetree@vger.kernel.org, Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Alistair Popple <apopple@au1.ibm.com>, Balbir Singh <bsingharora@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/4] powerpc/mm: allow memory hotplug into a memoryless
 node
In-Reply-To: <1478562276-25539-2-git-send-email-arbab@linux.vnet.ibm.com>
References: <1478562276-25539-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1478562276-25539-2-git-send-email-arbab@linux.vnet.ibm.com>
Date: Thu, 10 Nov 2016 12:37:10 +1100
Message-ID: <87k2ccjet5.fsf@concordia.ellerman.id.au>
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

Reza Arbab <arbab@linux.vnet.ibm.com> writes:

> Remove the check which prevents us from hotplugging into an empty node.
>
> The original commit b226e4621245 ("[PATCH] powerpc: don't add memory to
> empty node/zone"), states that this was intended to be a temporary measure.
> It is a workaround for an oops which no longer occurs.
>
> Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Acked-by: Balbir Singh <bsingharora@gmail.com>
> Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> Cc: Bharata B Rao <bharata@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/numa.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)

This seems OK from a powerpc perspective.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
