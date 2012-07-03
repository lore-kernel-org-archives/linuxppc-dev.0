Return-Path: <cl@linux.com>
Received: from smtp106.prem.mail.ac4.yahoo.com
 (smtp106.prem.mail.ac4.yahoo.com [76.13.13.45])
 by ozlabs.org (Postfix) with SMTP id C9D302C00C9
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jul 2012 04:48:07 +1000 (EST)
Date: Tue, 3 Jul 2012 13:48:01 -0500 (CDT)
From: Christoph Lameter <cl@linux.com>
To: Li Zhong <zhong@linux.vnet.ibm.com>
Subject: Re: [PATCH powerpc 2/2] kfree the cache name  of pgtable cache if
 SLUB is used
In-Reply-To: <1340618099.13778.39.camel@ThinkPad-T420>
Message-ID: <alpine.DEB.2.00.1207031344240.14703@router.home>
References: <1340617984.13778.37.camel@ThinkPad-T420>
 <1340618099.13778.39.camel@ThinkPad-T420>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>, Pekka Enberg <penberg@kernel.org>,
 linux-mm <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>,
 Matt Mackall <mpm@selenic.com>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 25 Jun 2012, Li Zhong wrote:

> This patch tries to kfree the cache name of pgtables cache if SLUB is
> used, as SLUB duplicates the cache name, and the original one is leaked.

SLAB also does not free the name. Why would you have an #ifdef in there?
