Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EB9C867C2A
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Oct 2006 14:38:36 +1000 (EST)
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on i386
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicholas Miell <nmiell@comcast.net>
In-Reply-To: <1159840091.2349.0.camel@entropy>
References: <20061002214954.GD665@shell0.pdx.osdl.net>
	<20061002234428.GE3278@stusta.de>  <20061003012241.GF3278@stusta.de>
	<1159840091.2349.0.camel@entropy>
Content-Type: text/plain
Date: Tue, 03 Oct 2006 14:37:40 +1000
Message-Id: <1159850260.5482.34.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Judith Lebzelter <judith@osdl.org>,
	linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Won't this also cause warnings for valid arch-specific usage (i.e. in
> linux/arch/{i386,x86_64})?

I wouldn't cause that usage valid :)

Ben.
