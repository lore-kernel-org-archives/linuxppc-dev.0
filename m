Return-Path: <michael@ellerman.id.au>
Date: Fri, 2 Aug 2013 12:32:59 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/8] Add all memory via sysfs probe interface at once
Message-ID: <20130802023259.GC1680@concordia>
References: <51F01E06.6090800@linux.vnet.ibm.com>
 <51F01EFB.6070207@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51F01EFB.6070207@linux.vnet.ibm.com>
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

On Wed, Jul 24, 2013 at 01:37:47PM -0500, Nathan Fontenot wrote:
> When doing memory hot add via the 'probe' interface in sysfs we do not
> need to loop through and add memory one section at a time. I think this
> was originally done for powerpc, but is not needed. This patch removes
> the loop and just calls add_memory for all of the memory to be added.

Looks like memory hot add is supported on ia64, x86, sh, powerpc and
s390. Have you tested on any?
 
cheers
