Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D72FCDDEB6
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 09:06:51 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7DBC0977-0367-40F5-8A30-ACA02FD4E9FA@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: boards in arch/ppc -> arch/powerpc for 85xx
Date: Mon, 15 Oct 2007 18:07:06 -0500
To: Stefan Roese <sr@denx.de>, Dan Malek <dan@embeddedalley.com>,
	David Woodhouse <dwmw2@infradead.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Guys,

I was wondering if you cared about the following boards existing in  
arch/powerpc:

* STX GP3
* TQM 85xx
* SBC 8560

I'm told WR doesn't care about the SBC 8560, so I'll see if David does.

I'm willing to look into doing the port over, but would need some  
help testing.

- k
