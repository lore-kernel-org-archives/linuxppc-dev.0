Date: Tue, 8 Dec 1998 16:52:59 -0700 (MST)
From: Cort Dougan <cort@persephone.cs.nmt.edu>
To: Dan Malek <dmalek@jlc.net>
cc: Troy Benjegerdes <hozer@drgw.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: PReP RTC vs Decrementer accuracy...
In-Reply-To: <366D8CF9.55DF77F9@jlc.net>
Message-ID: <Pine.LNX.3.96.981208165142.11398A-100000@persephone.cs.nmt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The hardware is more stable, of course, but we can miss when handling it.
Take a look at the decrementer code - I think it's possible to miss a decr
when resetting it.  That could explain drift.

}Nope, not even close.  If you convert rtc drift specifications and
}processor oscillator drift specifications to a common reference (like
}PPM) you will see processor oscillators are significantly better


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
