Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406tsv45J9zF23b
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 17:29:07 +1100 (AEDT)
Message-ID: <1521786531.16434.335.camel@kernel.crashing.org>
Subject: Re: [PATCH 3/3] powerpc/mm: Fixup tlbie vs store ordering issue on
 POWER9
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, paulus@samba.org,
 mpe@ellerman.id.au, mauricfo@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Date: Fri, 23 Mar 2018 17:28:51 +1100
In-Reply-To: <20180323045627.16800-3-aneesh.kumar@linux.vnet.ibm.com>
References: <20180323045627.16800-1-aneesh.kumar@linux.vnet.ibm.com>
 <20180323045627.16800-3-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-03-23 at 10:26 +0530, Aneesh Kumar K.V wrote:
> +#define CPU_FTR_TLBIE_BUG              LONG_ASM_CONST(0x2000000000000000)

I did ask you to make this CPU_FTR_POWER9_TLBIE_BUG...

Cheers,
Ben
