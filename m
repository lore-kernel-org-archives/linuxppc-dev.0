Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1FB08DDE0E
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2008 15:21:16 +1000 (EST)
Subject: Re: ide pmac breakage
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <20080729141750V.fujita.tomonori@lab.ntt.co.jp>
References: <1217208596.11188.144.camel@pasglop>
	<1217210545.11188.146.camel@pasglop>
	<200807281631.56446.bzolnier@gmail.com>
	<20080729141750V.fujita.tomonori@lab.ntt.co.jp>
Content-Type: text/plain
Date: Tue, 29 Jul 2008 15:20:57 +1000
Message-Id: <1217308857.11188.237.camel@pasglop>
Mime-Version: 1.0
Cc: linux-ide@vger.kernel.org, petkovbb@gmail.com, bzolnier@gmail.com,
	linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-07-29 at 14:17 +0900, FUJITA Tomonori wrote:
> If q->elevator is NULL, the media-bay code might mess up the ref
> counting of the request queue...

Well, all I do is call into Bart's new helpers to scan for or unregister
devices ...

Ben.
