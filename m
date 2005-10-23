Return-Path: <rupert@ces.ch>
Received: from server1.serv-net.de (31.204.203.213.rev.inetbone.net
	[213.203.204.31])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A8F7C685E8
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Oct 2005 23:12:01 +1000 (EST)
From: Rupert Eibauer <rupert@ces.ch>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sun, 23 Oct 2005 15:27:45 +0200
References: <200510221554.03810.rupert@ces.ch>
	<200510231136.51548.rupert@ces.ch>
	<1130061332.7919.63.camel@gaston>
In-Reply-To: <1130061332.7919.63.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200510231527.46630.rupert@ces.ch>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH][RFT] Extended BAT features, take 2
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Please don't test my last patch, it will breaks some page table code.
