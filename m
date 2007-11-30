Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DE1B6DDE24
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Dec 2007 10:38:04 +1100 (EST)
Subject: Re: [RFC/PATCH] Add a device_initcall to machdep_calls
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40711301530k6001d563mb910f10b0d95503c@mail.gmail.com>
References: <20071130225043.12499.86364.stgit@trillian.secretlab.ca>
	<1196463486.13230.116.camel@pasglop>
	<fa686aa40711301530k6001d563mb910f10b0d95503c@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 01 Dec 2007 10:32:35 +1100
Message-Id: <1196465556.13230.120.camel@pasglop>
Mime-Version: 1.0
Cc: olof@lixom.net, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Is that level of sophistication really warranted for this scenario?

It's not -that- sophisticated and I want to have access to all
init levels, not just device and I don't like adding ad-hoc ppc_md.
calls that much.

Ben.
