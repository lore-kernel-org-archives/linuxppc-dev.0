Return-Path: <srs0=odlw=4r=bombadil.srs.infradead.org=batv+20fadfe1c4e01d3c2e43+5009+infradead.org+hch@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wNlGl2HG0zDqLt
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 17:34:07 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wNlGl1JsLz8t1b
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 17:34:07 +1000 (AEST)
Date: Thu, 11 May 2017 00:34:02 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: gleb@kernel.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Paul Mackerras <paulus@samba.org>, pbonzini@redhat.com,
 Michael Ellerman <mpe@ellerman.id.au>, kvm@vger.kernel.org,
 david@gibson.dropbear.id.au
Subject: Re: [PATCH v9 2/3] powerpc/book3s: EXPORT_SYMBOL
 machine_check_print_event_info
Message-ID: <20170511073402.GA3828@infradead.org>
References: <149448323691.12206.11861424815113458031.stgit@jupiter.in.ibm.com>
 <149448334581.12206.14093241775576407387.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <149448334581.12206.14093241775576407387.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

EXPORT_SYMBOL_GPL for random non-coherent exports for single users,
please.
