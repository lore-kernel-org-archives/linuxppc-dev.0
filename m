Return-Path: <michael@ellerman.id.au>
Date: Mon, 5 Aug 2013 13:13:26 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/8] Add all memory via sysfs probe interface at once
Message-ID: <20130805031326.GB5347@concordia>
References: <51F01E06.6090800@linux.vnet.ibm.com>
 <51F01EFB.6070207@linux.vnet.ibm.com>
 <20130802023259.GC1680@concordia>
 <51FC04C2.70100@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51FC04C2.70100@linux.vnet.ibm.com>
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

On Fri, Aug 02, 2013 at 02:13:06PM -0500, Nathan Fontenot wrote:
> On 08/01/2013 09:32 PM, Michael Ellerman wrote:
> > On Wed, Jul 24, 2013 at 01:37:47PM -0500, Nathan Fontenot wrote:
> >> When doing memory hot add via the 'probe' interface in sysfs we do not
> >> need to loop through and add memory one section at a time. I think this
> >> was originally done for powerpc, but is not needed. This patch removes
> >> the loop and just calls add_memory for all of the memory to be added.
> > 
> > Looks like memory hot add is supported on ia64, x86, sh, powerpc and
> > s390. Have you tested on any?
> 
> I have tested on powerpc. I would love to say I tested on the other
> platforms... but I haven't.  I should be able to get a x86 box to test
> on but the other architectures may not be possible.

Is the rest of your series dependent on this patch? Or is it sort of
incidental?

If possible it might be worth pulling this one out and sticking it in
linux-next for a cycle to give people a chance to test it. Unless
someone who knows the code well is comfortable with it.

cheers
