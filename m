Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5E7E51A0597
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Dec 2014 14:14:45 +1100 (AEDT)
Message-ID: <1417489766.27448.0.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/2] powerpc/mm: don't do tlbie for updatepp request
 with NO HPTE fault
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Tue, 02 Dec 2014 14:09:26 +1100
In-Reply-To: <1415026295-25965-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1415026295-25965-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1415026295-25965-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

On Mon, 2014-11-03 at 20:21 +0530, Aneesh Kumar K.V wrote:
> upatepp get called for a nohpte fault, when we find from the linux
> page table that the translation was hashed before. In that case
> we are sure that there is no existing translation, hence we could
> avoid doing tlbie.

You need to test your own stuff together :-)

/home/benh/linux-powerpc-test/arch/powerpc/mm/hugepage-hash64.c: In function '__hash_page_thp':
/home/benh/linux-powerpc-test/arch/powerpc/mm/hugepage-hash64.c:98:17: error: 'local' undeclared (first use in this function)
/home/benh/linux-powerpc-test/arch/powerpc/mm/hugepage-hash64.c:98:17: note: each undeclared identifier is reported only once for each function it appears in

Cheers,
Ben.
