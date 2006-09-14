Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.ovro.caltech.edu",
	Issuer "mail.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2D4DF67B72
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Sep 2006 04:03:39 +1000 (EST)
Message-ID: <450998DC.1010604@ovro.caltech.edu>
Date: Thu, 14 Sep 2006 11:01:00 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: stonepine <stonepine@126.com>
Subject: Re: 11-16-05 2.6.14 on AMCC Yosemite boar d(PCI-IDE card boot error)
References: <45077EA4.000010.14180@bj126app9.126.com>
	<450865ED.4080000@bmrtech.com>
	<4508A606.90505@ovro.caltech.edu> <450996FB.5050408@126.com>
In-Reply-To: <450996FB.5050408@126.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> The problem was addressed with your help, and I do really appreciate your help.

Great!

I hope you learned your lesson though: when something breaks, make
sure to re-test using the head of the git repo. Of course that may
break something too, but most other developers will also be working
from the head, so can probably reproduce your problem.
(Or will be more likely to listen to any complaints).

Also its worth writing a couple of simple drivers; one that
maps a PCI IO memory space and another that maps PCI memory
space. That way you can cause the machine check in a very
basic driver, i.e., your problem had nothing to do with
your specific card.

Take a look at the LNX-723 document and code, I wrote
it while using a Yosemite board, but have moved on
to a Freescale MPC8349E device, since the 440EP wasn't
going to work for my application:

http://www.ovro.caltech.edu/~dwh/correlator/cobra_docs.html

Here's a copy of my test notes:
http://www.ovro.caltech.edu/~dwh/powerpc_440ep.pdf

Cheers
Dave
