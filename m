Date: Mon, 7 Dec 1998 22:00:07 -0700 (MST)
From: Cort Dougan <cort@persephone.cs.nmt.edu>
To: Troy Benjegerdes <hozer@drgw.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: PReP RTC vs Decrementer accuracy...
In-Reply-To: <Pine.LNX.4.04.9812071456450.13527-100000@narn.local.drgw.net>
Message-ID: <Pine.LNX.3.96.981207215711.7923A-100000@persephone.cs.nmt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Right, the rtc is probably more accurate over a long period of time.  The
idea is that the rtc will be sync'd with the decrementer so when we change
time it'll be set in the rtc as well.  The drift should be corrected by
a time daemon.

If my assumption here isn't correct let me know.  I'm not adamant about
this and if I'm wrong about this I'm happy to change it.

}The PReP code also tries to reset the RTC to match the Kernel's
}(decrementer's) version of the time every 11 minutes or so. The question I
}have is, isn't the RTC more accurate for long periods of time?


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
