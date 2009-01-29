Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 86135DE142
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 09:11:15 +1100 (EST)
Subject: Re: Broken PCI on Sequoia
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <alpine.LRH.2.00.0901291819440.22142@vixen.sonytel.be>
References: <alpine.LRH.2.00.0901291819440.22142@vixen.sonytel.be>
Content-Type: text/plain
Date: Fri, 30 Jan 2009 09:11:01 +1100
Message-Id: <1233267061.18767.5.camel@pasglop>
Mime-Version: 1.0
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-01-29 at 18:37 +0100, Geert Uytterhoeven wrote:
> 	Hi Ben, Josh,


 .../...

> Git-reverting this commit on top of 2.6.29-rc3 makes the crash go away.
> 
> Perhaps sequoia.dts (and other 44x DTS files) had to be changed, too?

Weird, maybe I have a bug when there is no ISA hole in the DT, I'll have
a look later today.

Cheers,
Ben.
