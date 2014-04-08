Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 481AC140113
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Apr 2014 12:47:16 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 7 Apr 2014 22:47:12 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 3CA5C6E803F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Apr 2014 22:47:04 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23033.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s382lAKU8323484
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Apr 2014 02:47:10 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s382l9Ll032056
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Apr 2014 22:47:10 -0400
Message-ID: <5343632B.5040205@linux.vnet.ibm.com>
Date: Mon, 07 Apr 2014 21:47:07 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Greg Kurz <gkurz@linux.vnet.ibm.com>, benh@kernel.crashing.org
Subject: Re: [PATCH v2] powerpc/le: enable RTAS events support
References: <0140402175658.1b4a8c4d@bahia.local>
 <20140404072750.20016.18969.stgit@bahia.local>
In-Reply-To: <20140404072750.20016.18969.stgit@bahia.local>
Content-Type: text/plain; charset=UTF-8
Cc: linux-kernel@vger.kernel.org, paulus@samba.org, anton@samba.org,
 geert@linux-m68k.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/04/2014 02:35 AM, Greg Kurz wrote:
> The current kernel code assumes big endian and parses RTAS events all
> wrong. The most visible effect is that we cannot honor EPOW events,
> meaning, for example, we cannot shut down a guest properly from the
> hypervisor.
> 
> This new patch is largely inspired by Nathan's work: we get rid of all
> the bit fields in the RTAS event structures (even the unused ones, for
> consistency). We also introduce endian safe accessors for the fields used
> by the kernel (trivial rtas_error_type() accessor added for consistency).
> 
> Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>

Looks good, thanks for getting this done Greg.
-Nathan
