Date: Mon, 30 Aug 1999 11:20:07 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Kevin Puetz <puetzk@iastate.edu>
cc: Ira K Weiny <iweiny@falcon.csc.calpoly.edu>, lambert@jeol.com,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Communicator Crashes X II
In-Reply-To: <199908301312.IAA02257@mailhub.iastate.edu>
Message-ID: <Pine.LNX.3.96LJ1.1b7.990830105621.10779A-100000@selq119.unl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 30 Aug 1999, Kevin Puetz wrote:

> A serial port buffer issue is behind the 'FB. overflow ####' crash, also 
> often exposed during VT changes while PPP is running.

I think this crash will occur less often, once serial DMA support is
present.  I've just started writing the necessary DMA code, and I hope to
get something working within a few weeks for the receiving side.

> This could be related. Or it might not. I really don't know the subsystem
> well enough to say.

I don't really know either, but kernel may be spending too much time in
the interrupt handling section of the serial driver.


Takashi Oe


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
