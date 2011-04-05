Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6D17A100896
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Apr 2011 16:52:35 +1000 (EST)
Subject: Re: [PATCH 02/15] powerpc/rtas: Check RTAS presence when testing
	indicators
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1301985372.3620.12.camel@concordia>
References: <1301984051-18413-1-git-send-email-benh@kernel.crashing.org>
	<1301984051-18413-3-git-send-email-benh@kernel.crashing.org>
	<1301985372.3620.12.camel@concordia>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 05 Apr 2011 16:52:26 +1000
Message-ID: <1301986346.2549.142.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> Why? of_get_property() returns NULL if np is NULL, implemented in
> of_find_property(). It doesn't look like a fast path.

Fun... not sure, I though I had a problem but maybe I don't remember
properly :-)

Cheers,
Ben.
