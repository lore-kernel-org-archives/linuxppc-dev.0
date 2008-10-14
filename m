Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BC286DDE03
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 19:22:06 +1100 (EST)
Subject: Re: [RFC 1/3] hvc_console: rework setup to replace irq functions
	with callbacks
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <200810140842.31806.borntraeger@de.ibm.com>
References: <200806031444.21945.borntraeger@de.ibm.com>
	<200810130951.31733.borntraeger@de.ibm.com>
	<1223944714.8157.300.camel@pasglop>
	<200810140842.31806.borntraeger@de.ibm.com>
Content-Type: text/plain
Date: Tue, 14 Oct 2008 19:18:51 +1100
Message-Id: <1223972331.8157.331.camel@pasglop>
Mime-Version: 1.0
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
	Virtualization Mailing List <virtualization@lists.osdl.org>,
	Rusty Russell <rusty@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>,
	Linux PPC devel <linuxppc-dev@ozlabs.org>, Ingo Molnar <mingo@elte.hu>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-10-14 at 08:42 +0200, Christian Borntraeger wrote:
> Am Dienstag, 14. Oktober 2008 schrieb Benjamin Herrenschmidt:
> > 
> > > Hmmm. 
> > > Can you try if this patch fixes the lockdep trace?
> > 
> > Yup, the patch fixes it, I'll commit it via the powerpc.git tree if you
> > don't have any objection.
> 
> Sure, go ahead.

Allright, I have a batch about ready to go to Linus, so I'll add that
and ask him to pull tomorrow.

Thanks,
Ben.
