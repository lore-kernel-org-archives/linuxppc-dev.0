Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AECF7474EB
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jan 2009 16:02:50 +1100 (EST)
Subject: Re: [PATCH 5/5] ide: Force VIA IDE legacy interrupts for AmigaOne
	boards
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
In-Reply-To: <20090112233909.221080@gmx.net>
References: <20090112233909.221080@gmx.net>
Content-Type: text/plain
Date: Tue, 13 Jan 2009 16:02:38 +1100
Message-Id: <1231822958.22571.38.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Yes, it can wait.
> Although I would like to know from the powerpc maintainer, if my platform
> patches could still go in 2.6.29, if I resend them in the next days? I guess it's
> too late, right?

Yes it is. I'll put them in -next after -rc2 or later, when we are happy
with them. That gives us a bit of time to do extra polishing.

Ben.
