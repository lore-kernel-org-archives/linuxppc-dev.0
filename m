Date: Thu, 8 Jul 1999 15:34:47 -0400 (EDT)
From: Hollis R Blanchard <hollis+@andrew.cmu.edu>
To: Jason Haas <jhaas@madison-web.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: QuickTime Streaming Server for Linux.. on x86
In-Reply-To: <3784D927.FFEAEFC9@madison-web.com>
Message-ID: <Pine.LNX.3.96L.990708153028.2134L-100000@unix47.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 8 Jul 1999, Jason Haas wrote:
> 
> Apparently Apple's releasing part of the QT Streaming Server as "open
> source". It'll run on Mac OS X Server and Linux/x86.
> 
> Hmm.
> 
> http://theregister.co.uk/990708-000012.html
> 
> What's slightly wrong with this picture?

Nope, doesn't compile. Lots of warnings (mostly implicit function
declarations) for the library, and then the server compile dies with

main.cpp: In function `int main(int, char **)':
main.cpp:101: no match for `__sigset_t & = int'
/usr/include/bits/sigset.h:31: candidates are: __sigset_t::operator =(const
{anonymous struct} &)

Also, lots and lots of "warning: multi-character character constant" coming
from lines like

static const FourCharCode kFractionLostPacketsSig = 'frac';

Should those single ticks be quotes?

-Hollis


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
