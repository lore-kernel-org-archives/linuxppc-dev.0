Message-ID: <000f01c47172$591008d0$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "Kevin P. Dankwardt" <k@kcomputing.com>,
	"Embedded Linux PPC list" <linuxppc-embedded@lists.linuxppc.org>
References: <KCEOLLHGFJIAFNAMGACHMEMODPAA.k@kcomputing.com>
Subject: Re: Linux is not reliable enough?
Date: Sat, 24 Jul 2004 07:35:36 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kevin,

I suspect you have a political problem here.  Mr. Chief Software Architect
(which is a title for someone who doesn't actually *do* anything) is not
going to lose his job for choosing QNX.  My suggestion is this:  Point out
that the only way to prove reliability is with testing.  Linux is open
source, it won't cost anything to put it on a side by side test, and let
Linux speak for itself.

- Linux is open source, any potential bugs are theoretically fixable.  What
do you do if QNX develops a problem?
- You can hunt around for some of Linus's comments about microkernal
architecture.  He thinks they're stupid, only he's says it more poetically.
- Don't fall into this trap of software mysticism, that one operating system
is somehow intrinsically more reliable than another.  There's good and bad
software, to be sure, but even Windows can be reliable in certain carefully
constrained environments.  It's only ones and zeros.

My $.02

Mark Chambers

----- Original Message -----
From: "Kevin P. Dankwardt" <k@kcomputing.com>
To: "Embedded Linux PPC list" <linuxppc-embedded@lists.linuxppc.org>
Sent: Friday, July 23, 2004 5:06 PM
Subject: Linux is not reliable enough?


>
> I am working with a team on a project where their customer is concerned
> about the reliability of Linux. The customer wants to go with QNX because
of
> the belief that QNX Neutrino is inherently more reliable. This belief
> revolves around the differences in design where drivers in QNX do not
reside
> in the same address space as the (micro-)kernel.
>
> What the team was hoping to use is a MPC5200 based system and the ELDK.
>
<snip>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
