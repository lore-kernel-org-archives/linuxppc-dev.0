From: Brad Boyer <flar@cegt201.bradley.edu>
Message-Id: <199905072136.QAA18422@cegt201.bradley.edu>
Subject: Re: Question about SMP
To: ranga@CSUA.Berkeley.EDU (Sriranga Veeraraghavan)
Date: Fri, 7 May 1999 16:36:55 -0500 (CDT)
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <199905071754.KAA09699@soda.CSUA.Berkeley.EDU> from "Sriranga Veeraraghavan" at May 7, 99 10:54:03 am
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >From you post, I take it that my SMP kernel didn't work for you. What
> was the exact problem you had?

Well, the 2.2.0pre6 kernel I downloaded didn't even boot.  Not from OF
when I downloaded it in Linux, and not from BootX when I downloaded it
in the MacOS.  And I downloaded different ones each time, to get the
appropriate compression for the OS.  In BootX, it just printed the
"Welcome to Linux" line and hung.  It didn't do much better in OF, as
I recall.  I also downloaded a 2.2.7 kernel from someone at MIT who
gave me a URL, but while it worked better, it still wasn't actually
useable.  It did the same thing as the one I compiled from the 2.2.7
source.  It did all the initial stuff, started init, printed the
message about swap, and then started printing the spinlock errors.  I
hope someone has some idea what's happening here.  I know my second
processor works, because I've used it in the MacOS and BeOS...

		 Brad Boyer
		 flar@cegt201.bradley.edu

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
