Return-Path: <n-horiguchi@ah.jp.nec.com>
Received: from tyo185.gate.nec.co.jp (tyo185.gate.nec.co.jp [114.179.232.185])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wDC6S1HQ7zDq72
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 19:57:19 +1000 (AEST)
Received: from tyo162.gate.nec.co.jp (tyo162.gate.nec.co.jp [114.179.232.162])
 by tyo185.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id
 v3R9emDS016758
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 18:40:49 +0900
From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 2/7] mm/follow_page_mask: Split follow_page_mask to
 smaller functions.
Date: Thu, 27 Apr 2017 09:39:42 +0000
Message-ID: <20170427093942.GB8842@hori1.linux.bs1.fc.nec.co.jp>
References: <1492449106-27467-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1492449106-27467-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1492449106-27467-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="iso-2022-jp"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 17, 2017 at 10:41:41PM +0530, Aneesh Kumar K.V wrote:
> Makes code reading easy. No functional changes in this patch. In a follow=
up
> patch, we will be updating the follow_page_mask to handle hugetlb hugepd =
format
> so that archs like ppc64 can switch to the generic version. This split he=
lps
> in doing that nicely.
>=20
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Reviewed-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>=
