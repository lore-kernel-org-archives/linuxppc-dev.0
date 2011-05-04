Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7206BB6F6E
	for <linuxppc-dev@ozlabs.org>; Wed,  4 May 2011 15:37:23 +1000 (EST)
Subject: Re: Read/write BCSR registers of PPC460EX
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20110502124039.GB3269@zod.rchland.ibm.com>
References: <31522823.post@talk.nabble.com>
	<20110502124039.GB3269@zod.rchland.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 04 May 2011 15:37:00 +1000
Message-ID: <1304487420.2513.352.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linuxppc-dev <eftakhar.chowdhury@yahoo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-05-02 at 08:40 -0400, Josh Boyer wrote:
> Aside from minor things like using unsigned int instead of unsigned
> long, the code looks correct.  The thing to check is if you are
> ioremapping the right physical address, and making sure you're reading
> a
> proper location. 

Which is why he should obtain the location from the device-tree rather
than hard coding it !

Cheers,
Ben.
