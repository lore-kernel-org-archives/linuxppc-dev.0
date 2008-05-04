Return-Path: <roland@redhat.com>
Received: from QMTA03.emeryville.ca.mail.comcast.net
	(qmta03.emeryville.ca.mail.comcast.net [76.96.30.32])
	by ozlabs.org (Postfix) with ESMTP id 29020DDDFC
	for <linuxppc-dev@ozlabs.org>; Mon,  5 May 2008 09:12:42 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: benh@kernel.crashing.org
Subject: Re: how to check for "optional" ppc chip features (MSR_BE)
In-Reply-To: Benjamin Herrenschmidt's message of  Monday,
	5 May 2008 07:45:49 +1000 <1209937549.21644.2.camel@pasglop>
References: <20080502012118.96ED926FA07@magilla.localdomain>
	<DC173CDE-FBC4-4EA0-8022-3F993B6466BF@kernel.crashing.org>
	<1209937549.21644.2.camel@pasglop>
Message-Id: <20080504231207.8377E26FA08@magilla.localdomain>
Date: Sun,  4 May 2008 16:12:07 -0700 (PDT)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Oh and classic pitfall: If you define a new feature bit, make sure
> CPU_FTRS_POSSIBLE is updated to contain it in cputable.h

Yeah, all that stuff I could figure out as needed.  What I really meant
was, where is the big official table of which chips behave which ways that
you base all code that on?  Actually, I don't really care as long as you
all are happy to be responsible for figuring out what matters.  With the
patch I posted to use MSR_BE, I took Kumar Gala's word as gospel that all
the chips on which we use MSR_SE also have MSR_BE.  If that's not right,
then I hope you'd like to pick a feature bit, populate the tables, etc.,
and fix the definition of arch_has_block_step() as appropriate.


Thanks,
Roland
