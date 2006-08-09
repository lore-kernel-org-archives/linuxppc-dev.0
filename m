Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F144467B69
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Aug 2006 01:38:35 +1000 (EST)
Subject: Re: [PATCH][0/2] RTAS MSI
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1155090210.7087.4.camel@localhost.localdomain>
References: <1154024154.29826.229.camel@goblue>
	<1154062599.21801.40.camel@localhost.localdomain>
	<802085A1-AA37-4787-A2D6-B619C6BE7AB4@kernel.crashing.org>
	<1155090210.7087.4.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 09 Aug 2006 17:38:10 +0200
Message-Id: <1155137891.17187.50.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> So this might lead to the state where the card has been configured to
> use x MSIs, but we only tell the driver about 1 of them. I don't know
> enough PCI to grok if that's going to be a problem.

It probably will

Ben.
