Message-Id: <199909301804.UAA00292@piglet.cpu.lu>
Date: Thu, 30 Sep 1999 20:04:29 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: 2.2.13 build OOB?; need for some standardization here? 
To: dje@watson.ibm.com
cc: khendricks@admin.ivey.uwo.ca, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <9909281839.AA40920@marc.watson.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

On  28 Sep, this message from David Edelsohn echoed through cyberspace:
> Kevin> I think we should either fix the way Linus and company decides when to release a 
> Kevin> stable version, or get our own "Alan Cox" to act as shepard over our own stable 
> Kevin> "ppc" kernel tree and make that person "official".
> 
> 	I tend to agree with Kevin here.  The Linux core kernel developers
> need to improve their release engineering process.  I realize that
> Linux/PPC was on the fringe for a long time, and both Paul and Cort have
> done a lot of excellent work these past few months adding functionality
> and improving the overall design.  This rapid development makes it hard
> for Linus and company to keep up.  However, x86 development should not
> break PowerPC and other ports as much as I have seen.

I fully agree here. I think every Linux arch should have a single person
responsible for the port, and new releases of stable kernel versions
should get every arch maintainer's OK before release. That would at
least catch most of the 'doesn't compile on...' type of bugs.

However, I fear that Paul, the current PPC maintainer according to
kernel documentation, would need to spend even more time on Linux
than he currently does... which I'm not sure he is prepared to do.

> 	PowerPC and other architectures are becoming more important and
> demonstrating the diversity of Linux.  The breakage and instability does
> not cast a good light on bazaar-style development model and Linux when we
> are trying to broaden the Linux market.

Absolutely true. There are two main problems I see here: getting PPC
patches into the kernel, and checking that other people's work on the
kernel doesn't break anything PPC-specific. Both problems caused
headaches in the past...

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
