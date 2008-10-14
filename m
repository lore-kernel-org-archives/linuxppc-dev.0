Return-Path: <borntraeger@de.ibm.com>
Received: from mtagate7.de.ibm.com (mtagate7.de.ibm.com [195.212.29.156])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 279F2DDDEA
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 17:43:04 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate7.de.ibm.com (8.13.8/8.13.8) with ESMTP id m9E6gX4J563734
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 06:42:33 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.1) with
	ESMTP id m9E6gX3P3727608
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 08:42:33 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m9E6gWcG023928
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 08:42:33 +0200
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [RFC 1/3] hvc_console: rework setup to replace irq functions with
	callbacks
Date: Tue, 14 Oct 2008 08:42:31 +0200
References: <200806031444.21945.borntraeger@de.ibm.com>
	<200810130951.31733.borntraeger@de.ibm.com>
	<1223944714.8157.300.camel@pasglop>
In-Reply-To: <1223944714.8157.300.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200810140842.31806.borntraeger@de.ibm.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
	Virtualization Mailing List <virtualization@lists.osdl.org>,
	Rusty Russell <rusty@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>,
	Linux PPC devel <linuxppc-dev@ozlabs.org>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Am Dienstag, 14. Oktober 2008 schrieb Benjamin Herrenschmidt:
> 
> > Hmmm. 
> > Can you try if this patch fixes the lockdep trace?
> 
> Yup, the patch fixes it, I'll commit it via the powerpc.git tree if you
> don't have any objection.

Sure, go ahead.
