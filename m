Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E317ADDF7B
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 08:10:01 +1000 (EST)
Subject: Re: Wrong looking statement in cpm_common.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20090526175613.GB9464@loki.buserror.net>
References: <1243224033.24376.18.camel@pasglop>
	<20090526175613.GB9464@loki.buserror.net>
Content-Type: text/plain
Date: Wed, 27 May 2009 08:07:51 +1000
Message-Id: <1243375671.17847.0.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2009-05-26 at 12:56 -0500, Scott Wood wrote:
> 
> Any suggestions for how to do it properly?

ioremap ? :-)

Ben.
