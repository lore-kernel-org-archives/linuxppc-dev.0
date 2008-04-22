Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B3C1BDE08B
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 17:56:58 +1000 (EST)
Subject: Re: Patches added to powerpc.git master and powerpc-next branches
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <C69E510D-5838-4BE6-AB57-56FCB0592414@kernel.crashing.org>
References: <18440.34891.440661.248400@cargo.ozlabs.ibm.com>
	<9CE9EFA8-A303-49C9-B9A2-F62D42F927B7@kernel.crashing.org>
	<18441.58154.608911.337978@cargo.ozlabs.ibm.com>
	<C69E510D-5838-4BE6-AB57-56FCB0592414@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 22 Apr 2008 17:56:50 +1000
Message-Id: <1208851010.9640.90.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2008-04-21 at 12:51 -0500, Kumar Gala wrote:

> I'm not clear on why this is needed.  I can see value in having the  
> PGD entry in place but the pte PAs would be changing all the time so
> I  
> don't see what benefit there is in keeping them in one page.

Because they are accessed as an array by the C code ?

Ben.
