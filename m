Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C8DE8B6F8A
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  4 May 2011 15:37:36 +1000 (EST)
Subject: Re: Read/write BCSR registers of PPC460EX
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <201105021542.45367.sr@denx.de>
References: <31522823.post@talk.nabble.com> <201105021453.32775.sr@denx.de>
	<31523658.post@talk.nabble.com>  <201105021542.45367.sr@denx.de>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 04 May 2011 15:37:26 +1000
Message-ID: <1304487446.2513.353.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <eftakhar.chowdhury@yahoo.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-05-02 at 15:42 +0200, Stefan Roese wrote:
> 
> Thats a 64bit address, so you need this:
> 
> static unsigned long long mem_addr =  0x4E1000000ULL;
> 
> You should have seen a compilation warning about this too. 

No, he should use the device-tree :-)

Cheers,
Ben.
