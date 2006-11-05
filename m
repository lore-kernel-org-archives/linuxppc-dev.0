Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 409FA67C85
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Nov 2006 09:51:38 +1100 (EST)
Subject: Re: [PATCH 2.6.19 4/4] ehca: ehca_av.c use constant for max mtu
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
In-Reply-To: <200611052142.56722.hnguyen@de.ibm.com>
References: <200611052142.56722.hnguyen@de.ibm.com>
Content-Type: text/plain
Date: Mon, 06 Nov 2006 09:48:40 +1100
Message-Id: <1162766921.28571.251.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	openib-general@openib.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Can you fix your patch sending technique ? A mangled patch inline with a
non-mangled one in attachment... that's a bit gross. Just get a proper
one inline and be done with it. If your mailer can't be coerced into not
damaging patches, then use another one for sending them.

Cheers,
Ben
