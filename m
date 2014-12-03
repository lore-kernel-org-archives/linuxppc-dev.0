Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 117C21A0185
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Dec 2014 14:37:44 +1100 (AEDT)
Message-ID: <1417577863.16722.10.camel@concordia>
Subject: Re: [PATCH V2] powerpc/mm: don't do tlbie for updatepp request with
 NO HPTE fault
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 03 Dec 2014 14:37:43 +1100
In-Reply-To: <1417503002-22086-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1417503002-22086-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-12-02 at 12:20 +0530, Aneesh Kumar K.V wrote:
> upatepp get called for a nohpte fault, when we find from the linux
> page table that the translation was hashed before. In that case
> we are sure that there is no existing translation, hence we could
> avoid doing tlbie.

Same comments as last time.

http://patchwork.ozlabs.org/patch/406219/

cheers
