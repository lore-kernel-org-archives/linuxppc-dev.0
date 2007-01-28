Return-Path: <mingo@elte.hu>
Received: from fallback.mail.elte.hu (fallback.mail.elte.hu [157.181.151.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 77F69DE046
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 11:04:15 +1100 (EST)
Received: from mx2.mail.elte.hu ([157.181.151.9])
	by fallback.mail.elte.hu with esmtp (Exim) id 1HBHaY-0001gN-Ns
	from <mingo@elte.hu>
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Jan 2007 22:29:26 +0100
Date: Sun, 28 Jan 2007 22:26:18 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 0/6] MSI portability cleanups
Message-ID: <20070128212618.GA11547@elte.hu>
References: <1169714047.65693.647693675533.qpush@cradle>
	<m1hcubq6re.fsf@ebiederm.dsl.xmission.com>
	<1170015805.26655.15.camel@localhost.localdomain>
	<45BD0BDC.40205@garzik.org>
	<m1bqkiq25v.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <m1bqkiq25v.fsf@ebiederm.dsl.xmission.com>
Cc: Tony Luck <tony.luck@intel.com>, Grant Grundler <grundler@parisc-linux.org>,
	Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
	Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	Brice Goglin <brice@myri.com>,
	Greg Kroah-Hartman <greg@kroah.com>, shaohua.li@intel.com,
	linux-pci@atrey.karlin.mff.cuni.cz, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Eric W. Biederman <ebiederm@xmission.com> wrote:

> I'm not arguing against an operations based approach.  I'm arguing for 
> simple obviously correct steps, and not throwing the baby out with the 
> bath water.
> 
> My patches should be a precursor to an operations based approach
> because they are simple step from where we are now.

yeah. I'd say your approach is to go from A to B:

  [A] -----------------------------------------------------> [B]
                                                              |
                                                             [C]

while there might be some other arguments that "no, lets go to C 
instead", i say lets not throw away the already implemented and already 
working and nicely layered [A]->[B] transition, just because there's an 
argument whether the end result should be 'B' or 'C'. Unless someone who 
wants to see 'C' produces a patchset that walks the whole way i dont see 
any reason to not go with your patchset. It clearly removes alot of 
cruft.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
