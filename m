Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DB4AB679E2
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Jul 2006 08:53:12 +1000 (EST)
Subject: Re: G5 troubles booting powerpc-git (July 6)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: will_schmidt@vnet.ibm.com
In-Reply-To: <1152197602.14547.10.camel@farscape.rchland.ibm.com>
References: <1152197602.14547.10.camel@farscape.rchland.ibm.com>
Content-Type: text/plain
Date: Fri, 07 Jul 2006 08:53:05 +1000
Message-Id: <1152226385.9862.16.camel@localhost.localdomain>
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

On Thu, 2006-07-06 at 09:53 -0500, Will Schmidt wrote:
>         Any other G5's having troubles booting with the powerpc-git
>         tree? 
>         
>         Mine fails..   The last text to the console is "MacIO PCI driver
>         attached to Shasta chipset",  then the fans ramp up.  
>         
>         Booted earlier this week OK, so seems like a change in the last
>         couple
>         days did something bad

I suspect there's still something wrong with mpic map callback, I'm
working on it

Ben.
