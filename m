Return-Path: <michael@ellerman.id.au>
Message-ID: <1385085968.26020.0.camel@concordia>
Subject: Re: [PATCH 2/2] powerpc: mm: change pgtable index size for 64K page
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 22 Nov 2013 13:06:08 +1100
In-Reply-To: <1385077581.4882.30.camel@pasglop>
References: <1385000275-5988-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <1385000275-5988-2-git-send-email-pingfank@linux.vnet.ibm.com>
 <20131121221150.GB26359@iris.ozlabs.ibm.com>
 <1385077581.4882.30.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Liu Ping Fan <kernelfans@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-11-22 at 10:46 +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2013-11-22 at 09:11 +1100, Paul Mackerras wrote:
> > On Thu, Nov 21, 2013 at 10:17:55AM +0800, Liu Ping Fan wrote:
> > > For 64K page, we waste half of the pte_t page. With this patch, after
> > > changing PGD_INDEX_SIZE from 12 to 11, PTE_INDEX_SIZE from 8 to 9,
> > > we can improve the usage of pte_t page and shrink the continuous phys
> > > size for pgd_t.
> 
> Also you did you miss that we use the second half to store the
> per-subpage hash info when using 64k on top of HW 4k ?

Given the subtleties perhaps a nice big block comment is in order ? :)

cheers
