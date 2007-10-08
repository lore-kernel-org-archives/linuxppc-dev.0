Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B3548DDF43
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Oct 2007 18:12:07 +1000 (EST)
Subject: Re: Where are inb/outb macros?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Misbah khan <misbah_khan@engineer.com>
In-Reply-To: <13091078.post@talk.nabble.com>
References: <adf480660710061347l59903ba6vf6b327db674606a9@mail.gmail.com>
	<1191704881.6414.3.camel@pasglop> <200710070146.51140.arnd@arndb.de>
	<13091078.post@talk.nabble.com>
Content-Type: text/plain
Date: Mon, 08 Oct 2007 18:11:35 +1000
Message-Id: <1191831095.21971.45.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2007-10-08 at 00:09 -0700, Misbah khan wrote:
> inb/outb could be used from the usr space on x86 class PC-computer to access
> to io ports this is what i assume that you are trying 
> 
> You need to compile the program with -O option (expantion of Inline function
> )
> 
> To perform io operation on ports ioprem/iopl system call must be used (To
> get permissio to perform io operation)
> 
> Program must run as root 
> 
> on non 86 platform try using /dev/port device file in the application 

"io ports" don't mean much on non-x86 platforms (or rather can have
multiple meanings) which is why I'm asking what is he trying to od in
the first place.

Ben.
