Date: Mon, 26 Jul 2004 17:42:45 +0200 (CEST)
From: Marius Groeger <mgroeger@sysgo.com>
To: Mark Chambers <markc@mail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux is not reliable enough?
In-Reply-To: <004701c47317$073ce590$0301a8c0@chuck2>
Message-ID: <Pine.LNX.4.61.0407261723540.5019@mag.sysgo.com>
References: <KCEOLLHGFJIAFNAMGACHMEMODPAA.k@kcomputing.com>
 <000f01c47172$591008d0$0301a8c0@chuck2> <Pine.LNX.4.61.0407260940220.2134@mag.sysgo.com>
 <004701c47317$073ce590$0301a8c0@chuck2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 26 Jul 2004, Mark Chambers wrote:

> to a guy on the phone who assures her QNX can't fail.  So every OS, and
> every feature, has its pro's and con's.  The question for any CSA is not 'is
> this reliable' but 'can I make a reliable system using this component'?

I agree: reliability is very strongly connected to the actual
components being used, and the overall system design.

One point pro Microkernel approaches, and a one that the CSA may have
been after: they allow you to decouple things. People advocating Linux
as a "solves-everything" sometimes fail to see that there are numerous
applications which want to embrace the typical strengths of Linux
(that is, the general purpose OS with a GUI, networking, POSIX shell)
for having a nice front-end, or for non-critical functions. They still
*need* to have the critical stuff running in a certified environment.

In other words: without serious work (read: big $$$), and most likely
many, many modifications and limitations that take away almost all
dynamic that open source software is known and loved for, we're not
going to see Linux in applications which require DO-178B Level A
certification.

Having said that, we may be far beyond that CSA's intentions here. But
I think this is an interesting (albeit OT) discussion, regardless.

Regards,
Marius

--
Marius Groeger <mgroeger@sysgo.com>
SYSGO AG                      Embedded and Real-Time Software
Voice: +49 6136 9948 0                  FAX: +49 6136 9948 10
www.sysgo.com | www.elinos.com | www.osek.de | www.imerva.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
