Message-ID: <388D2F11.5B6EC6ED@netx4.com>
Date: Tue, 25 Jan 2000 00:05:21 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: duncanp@research.canon.com.au
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Embedded planet 860T CLLF HELP!
References: <20000125043638.22DD31B3F8@elph.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


duncanp@research.canon.com.au wrote:

> This works well for me - thanks.

Good.  Just remember, playing with two physical Ethernet ports
is sometimes a challenge....make sure you use separate network
numbers :-).

I had the chance to use a 66 MHz 860P CLLF.  I ran a TCP
source/sink set of programs between my iMac and the CLLF.  The
TCP/IP interface ran 30 Mbits/sec, so we are getting there.
I am assuming the CLLF was the slow end, I guess I will try
my G4 and make sure :-).


> If you haven't done any more work on this, i'll be happy to have a look
> at neatening things up.

I wouldn't spend any time right now.  The QS6612 has been
discontinued and Embedded Planet is changing the PHY.  We can
update the driver when the new PHY appears, and I will keep
you in mind :-).

Thanks.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
