Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 64CE6B7BB2
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Oct 2009 11:01:15 +1100 (EST)
Subject: Re: [PATCH 0/8]  Fix 8xx MMU/TLB
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Malek <dan@embeddedalley.com>
In-Reply-To: <21C04675-E563-49E2-B2E6-7CAB9D8BE985@embeddedalley.com>
References: <1255597466-30976-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<20091015165650.GA3837@compile2.chatsunix.int.mrv.com>
	<OFF665748B.AAF26319-ONC1257651.00296F23-C1257651.002D6BF7@transmode.se>
	<20091016202541.GA16358@compile2.chatsunix.int.mrv.com>
	<OF2BB5EF59.1EE0A77D-ONC1257652.003D79DC-C1257652.003EA687@LocalDomain>
	<OFA43B9FDF.F43B1705-ONC1257652.0041B12F-C1257652.004211A3@transmode.se>
	<1256597241.2076.38.camel@pasglop>
	<21C04675-E563-49E2-B2E6-7CAB9D8BE985@embeddedalley.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 27 Oct 2009 11:00:53 +1100
Message-ID: <1256601653.2076.51.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-10-26 at 16:26 -0700, Dan Malek wrote:
> Just be careful the get_user() doesn't regenerate the same
> translation error you are trying to fix by being here......

It shouldn't since it will always come up with a proper DAR but
you may want to double check before hand that your instruction
address you are loading from is -not- your marker value for bad DAR.

> It is nice doing things in C code, but you have to be aware
> of the environment and the side effects when in this kind 

Yup.

Cheers,
Ben.
