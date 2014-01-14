Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id 6CF042C008F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 15:30:19 +1100 (EST)
Date: Mon, 13 Jan 2014 20:32:03 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: thp: Fix crash on mremap
Message-Id: <20140113203203.f8cb0bed.akpm@linux-foundation.org>
In-Reply-To: <1389672810.6933.0.camel@pasglop>
References: <1388570027-22933-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1388572145.4373.41.camel@pasglop>
 <20140102021951.GA26369@node.dhcp.inet.fi>
 <20140113141748.0b851e1573e41bf26de7c0ae@linux-foundation.org>
 <1389672810.6933.0.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: aarcange@redhat.com, linux-mm@kvack.org, paulus@samba.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>, linuxppc-dev@lists.ozlabs.org,
 kirill.shutemov@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 14 Jan 2014 15:13:30 +1100 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Mon, 2014-01-13 at 14:17 -0800, Andrew Morton wrote:
> 
> > Did this get fixed?
> 
> Any chance you can Ack the patch on that thread ?
> 
> http://thread.gmane.org/gmane.linux.kernel.mm/111809
> 
> So I can put it in powerpc -next with a CC stable ? Or if you tell me
> tat Kirill Ack is sufficient then I'll go for it.

yup, it looks OK to me from a non-ppc perspective.  Please proceed as
described.
