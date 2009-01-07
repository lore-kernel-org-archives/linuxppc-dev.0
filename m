Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 95AF8DE865
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 17:55:30 +1100 (EST)
Subject: Re: [PATCH/RFC] sysfs cache code rewrite
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Lynch <ntl@pobox.com>
In-Reply-To: <1231311102.14860.80.camel@pasglop>
References: <20081224045554.GA6958@localdomain>
	<20090106212533.GB7376@localdomain> <1231311102.14860.80.camel@pasglop>
Content-Type: text/plain
Date: Wed, 07 Jan 2009 17:55:24 +1100
Message-Id: <1231311324.14860.81.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I don't know quite the detail of the new cpumask stuff ... It could be
> as simple as passing a pointer instead of the value in the
> cpumask_scnprintf call though...

Actually, I'll do more tests and if that ends up being the only needed
change, I'll push your patch with that small change out to powerpc next
tonight.

Cheers,
Ben.
