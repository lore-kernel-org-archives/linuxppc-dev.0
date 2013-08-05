Return-Path: <michael@ellerman.id.au>
Date: Mon, 5 Aug 2013 13:11:12 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/8] Mark powerpc memory resources as busy
Message-ID: <20130805031111.GA5347@concordia>
References: <51F01E06.6090800@linux.vnet.ibm.com>
 <51F01EB2.9060802@linux.vnet.ibm.com>
 <20130802022827.GB1680@concordia>
 <51FC0315.1010601@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51FC0315.1010601@linux.vnet.ibm.com>
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

On Fri, Aug 02, 2013 at 02:05:57PM -0500, Nathan Fontenot wrote:
> On 08/01/2013 09:28 PM, Michael Ellerman wrote:
> > On Wed, Jul 24, 2013 at 01:36:34PM -0500, Nathan Fontenot wrote:
> >> Memory I/O resources need to be marked as busy or else we cannot remove
> >> them when doing memory hot remove.
> > 
> > I would have thought it was the opposite?
> 
> Me too.
> 
> As it turns out the code in kernel/resource.c checks to make sure the
> IORESOURCE_BUSY flag is set when trying to release a resource.

OK, I guess there's probably some sane reason, but it does seem
backward.

cheers
