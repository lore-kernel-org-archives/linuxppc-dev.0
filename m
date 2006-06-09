Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E7C8B67C60
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jun 2006 14:39:44 +1000 (EST)
Subject: Re: Linux kernel 2.6 on IBM RS/6000 7025-F40
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christophe Simon <titof3000@hotmail.com>
In-Reply-To: <BAY109-F5B7EE1B27D613DA2C4281AC8A0@phx.gbl>
References: <BAY109-F5B7EE1B27D613DA2C4281AC8A0@phx.gbl>
Content-Type: text/plain
Date: Fri, 09 Jun 2006 14:38:35 +1000
Message-Id: <1149827915.12687.55.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-06-07 at 15:30 +0000, Christophe Simon wrote:
> Hi there,
> 
> Did someone succeeded in compiling a running 2.6 kernel on an IBM RS/6000 
> 7025-F40 (PReP arch) ? I have one of these machines, and it runs with a 
> 2.4.22 kernel built using the instructions gathered on 
> http://www.solinno.co.uk/7043-140/
> 
> It seems that this machine is quite problematic.
> 
> I tried to compile my own kernel with a stock 2.6.16.19, and after that 
> 2.6.7 patched with the files I found for the 2.6.7 (at 
> http://www.solinno.co.uk/7043-140/files/2.6.7/), but the system refuses to 
> boot with those twoo kernels  (the machine reboots or freezes before writing 
> any piece of information on the console...).
> 
> The site seems not to move anymore, and I'd like to have a 2.6 kernel 
> running because of his better performances ans extended functionalities, and 
> I'd like not to be stalled on 2.4.22 kernel...
> 
> I crawled the web hours and hours (Google is my friend, but it didn't help 
> me...) and I didn't find anything...

I've successfully booted a 43p, I don't know about F40 though. What is
the last message on the console when you try to boot the kernel ?

Ben.
