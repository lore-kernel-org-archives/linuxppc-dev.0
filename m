Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 987662BDF2
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Oct 2004 09:44:22 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arrigo Benedetti <arrigo@bologna.vision.caltech.edu>
In-Reply-To: <41816863.9020000@vision.caltech.edu>
References: <41816863.9020000@vision.caltech.edu>
Content-Type: text/plain
Date: Fri, 29 Oct 2004 09:39:31 +1000
Message-Id: <1099006771.29690.83.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: Disabling interrupts on a SMP system
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2004-10-28 at 14:45 -0700, Arrigo Benedetti wrote:
> Dear all,
> 
> how can I (temporarily) disable all or some specific interrupts on a 
> specific CPU in an SMP system
> from user space code? In my case this is an Apple dual G5 system.

You can't ... why do you want to do that ?

Ben.
