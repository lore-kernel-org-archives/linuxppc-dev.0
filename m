Date: Mon, 10 May 2004 22:58:08 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linuxppc-dev@lists.linuxppc.org
Cc: Sam Ravnborg <sam@ravnborg.org>
Subject: Efficient handling of RTP frames?
Message-ID: <20040510205808.GA4313@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all.

We (my company) are looking into a solution for transporting a high amount
of RTP packets across a single CPU. A 82xx, presumeably a 8270.
With high amount of RTP packets we are talking about 10 to 20.000 packets
per second with a payload size of ~64 bytes each (on top of UDP header).

The RTP packets needs to be sent between an external device connected
to one of the FCC's (needs to write our own driver here) and the Ethernet
port sitting on FCC1.

Does this sound like a dead-end doing this in Linux?

Can anyone point in a direction where to find more information
about how to realise this in the most efficiet way?

Google did not bring up anything useful.

Thanks in advance,

	Sam

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
