Date: Tue, 2 Feb 1999 16:09:42 +1100
Message-Id: <199902020509.QAA03152@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: kraxel@goldbach.in-berlin.de
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: 
	<Pine.LNX.4.05.9901301512490.313-100000@macintoy.masq.in-berlin.de>
	(message from Gerd Knorr on Sat, 30 Jan 1999 15:24:20 +0100 (CET))
Subject: Re: iMac: sound?
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <Pine.LNX.4.05.9901301512490.313-100000@macintoy.masq.in-berlin.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gerd Knorr <kraxel@goldbach.in-berlin.de> wrote:

> Is the existing Amiga/PowerMac DMAsound driver supported to work on the
> iMac too?  Simply insmoding it seems not to work, I get these messages in
> the syslog:
> 
> 	AWACS: error, status = 4f00d0
> 	DMA sound driver: Interrupt initialization failed

That's a symptom of macos having shut down the awacs chip.  I haven't
found any way short of a hard reset to start it up again.

The dmasound.c in my anon rsync tree (samba.anu.edu.au::linux-pmac-devel)
has very minimal burgundy support already.  I (and Peter Barker here)
are working on it now.

Paul.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
