Date: Wed, 26 May 2004 10:12:34 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Oliver Korpilla <okorpil@fh-landshut.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ioremap() question
Message-ID: <20040526171234.GA4255@gate.ebshome.net>
References: <40B4AB27.5020202@fh-landshut.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <40B4AB27.5020202@fh-landshut.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, May 26, 2004 at 04:35:19PM +0200, Oliver Korpilla wrote:
>
> Hello!
>
> I start with a CPU physical address somwhere within the PCI bridge space:
> 0x85000000
> Then I use ioremap_nocache on it to obtain a (range of) virtual address(es):
> 0xC302D000
> And then I use virt_to_bus() to obtain an address to hand over to the PCI
> device:
> 0x0302D000

You cannot use virt_to_bus() on ioremap returned addresses.

Eugene.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
