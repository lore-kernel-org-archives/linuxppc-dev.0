Return-Path: <cl@linux.com>
Received: from resqmta-ch2-02v.sys.comcast.net
 (resqmta-ch2-02v.sys.comcast.net [69.252.207.34])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AD9FE1A1BEE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2015 04:04:05 +1000 (AEST)
Date: Thu, 30 Jul 2015 12:59:03 -0500 (CDT)
From: Christoph Lameter <cl@linux.com>
To: Vlastimil Babka <vbabka@suse.cz>
cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
 David Rientjes <rientjes@google.com>, Greg Thelen <gthelen@google.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Pekka Enberg <penberg@kernel.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
 Johannes Weiner <hannes@cmpxchg.org>, linux-ia64@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, cbe-oss-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH v3 2/3] mm: unify checks in alloc_pages_node() and
 __alloc_pages_node()
In-Reply-To: <1438274071-22551-2-git-send-email-vbabka@suse.cz>
Message-ID: <alpine.DEB.2.11.1507301258500.5521@east.gentwo.org>
References: <1438274071-22551-1-git-send-email-vbabka@suse.cz>
 <1438274071-22551-2-git-send-email-vbabka@suse.cz>
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Acked-by: Christoph Lameter <cl@linux.com>
