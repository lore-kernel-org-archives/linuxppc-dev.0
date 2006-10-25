Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DF64067BEB
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 13:21:33 +1000 (EST)
Subject: Re: [PATCH] powerpc: Fix CHRP platforms with only 8259
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1161745918.3800.16.camel@localhost.localdomain>
References: <1161744878.22582.5.camel@localhost.localdomain>
	<1161745918.3800.16.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 25 Oct 2006 13:21:23 +1000
Message-Id: <1161746483.22582.7.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> You don't need module.h anymore do you ? :D

Bloody you ! :)

New patch on the way.

Ben.
