Message-ID: <004701c47317$073ce590$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "Marius Groeger" <mgroeger@sysgo.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <KCEOLLHGFJIAFNAMGACHMEMODPAA.k@kcomputing.com> <000f01c47172$591008d0$0301a8c0@chuck2> <Pine.LNX.4.61.0407260940220.2134@mag.sysgo.com>
Subject: Re: Linux is not reliable enough?
Date: Mon, 26 Jul 2004 09:46:58 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> On Sat, 24 Jul 2004, Mark Chambers wrote:
>
> > that the only way to prove reliability is with testing.  Linux is open
> > source, it won't cost anything to put it on a side by side test, and let
> > Linux speak for itself.
>
> Getting to the point where you can run this side by side test *will*
> cost money, and typically rather much, what's more. It is not likely
> that Kevin's customer is going to pay the implementation for two OSes,
> even if it is only to the prototype stage.
>

Yes, a good point.  But I'm speaking with a salesman voice.  For someone who
is an expert like Kevin he can no doubt prototype something fairly quickly,
and getting the customer to see something actually working is very powerful.
It puts the ball in the Chief Software Architect's (the CSA, hereafter :-)
court to justify the additional expense of QNX.

> So, thinking about the right OS for the job in advance, as they do, is
> a good idea. Only the thinking must be done right, of course :-)
>

Indeed.  I guess I should spell out what I think is wrong with the CSAs
apparent thinking:  He points out an aspect of linux, namely that drivers
can crash the system, as an issue that somehow makes linux intrinsically
unreliable.  But if you write drivers that don't crash the system then linux
is not unreliable.  The only operating system that doesn't allow a clever
programmer to crash is one that doesn't do anything.  Microkernels, they
say, allow you to do nifty things like replace the file system without
rebooting.  So that means you could swap in a buggy filesystem and destroy
the data on your disc/flash.  Without rebooting.  Which is good since you
won't be able to boot from your corrupted filesystem, which won't show up
until the next power failure, while the poor nurse with a flashlight talks
to a guy on the phone who assures her QNX can't fail.  So every OS, and
every feature, has its pro's and con's.  The question for any CSA is not 'is
this reliable' but 'can I make a reliable system using this component'?
Will the OS eat itself, or do I only have to worry about the mistakes I
make?  A carefully constructed linux system should be good for 5 or even 6
nines of reliability.

Mark Chambers


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
