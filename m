Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C37C9DE059
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 20:06:04 +1000 (EST)
Subject: Re: 2.6.26 does not boot on Pegasos
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
In-Reply-To: <20080715100033.GA5147@iram.es>
References: <20080715100033.GA5147@iram.es>
Content-Type: text/plain
Date: Tue, 15 Jul 2008 20:05:49 +1000
Message-Id: <1216116349.7740.101.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	David Woodhouse <dwmw2@infradead.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-07-15 at 12:00 +0200, Gabriel Paubert wrote:
> 	Hi,
> 
> I just tried to boot 2.6.26 on a Pegasos and the kernel does not boot.
> The last message I have is:
> gunzip (0xffffffff <----- some more hex digits)
> 
> The configuration has been created from a working 2.6.25 one with
> make oldconfig and answering N to new config options.
> 
> Anybody has seen this or do I have to start digging deeper?

Unfortunately, I don't have a pegasos anymore. David, did you get a
chance to test anything recent on yours ? Matt ?

Cheers,
Ben.
