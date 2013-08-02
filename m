Return-Path: <michael@ellerman.id.au>
Date: Fri, 2 Aug 2013 12:27:03 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/8] register bootmem pages for powerpc when sparse
 vmemmap is not defined
Message-ID: <20130802022703.GA1680@concordia>
References: <51F01E06.6090800@linux.vnet.ibm.com>
 <51F01E5F.80307@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51F01E5F.80307@linux.vnet.ibm.com>
Cc: linux-mm <linux-mm@kvack.org>, isimatu.yasuaki@jp.fujitsu.com,
 linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 24, 2013 at 01:35:11PM -0500, Nathan Fontenot wrote:
> Previous commit 46723bfa540... introduced a new config option
> HAVE_BOOTMEM_INFO_NODE that ended up breaking memory hot-remove for powerpc
> when sparse vmemmap is not defined.

So that's a bug fix that should go into 3.10 stable?

cheers
