Date: Wed, 9 Dec 1998 01:25:21 -0700 (MST)
From: Cort Dougan <cort@persephone.cs.nmt.edu>
To: Troy Benjegerdes <hozer@drgw.net>
cc: Dan Malek <dmalek@jlc.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: PReP RTC vs Decrementer accuracy...
In-Reply-To: <Pine.LNX.4.04.9812090128220.13527-100000@narn.local.drgw.net>
Message-ID: <Pine.LNX.3.96.981209012238.14552A-100000@persephone.cs.nmt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


No, this would tend to make it slower if anything.

}Okay, would this cause the clock to be fast? (mine was about 45 minutes
}fast) (And, is it feasable to make it 'impossible' to miss a decr?)

Rebooting a lot would affect it.  Are you running the code that sync's the
rtc with the system clock every 11 minutes?  If so, turning it off and
seeing which clock was accurate after a while would be a useful
experiment.

}I have also rebooted the machine quite a bit.. This may also be the
}reason.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
