Date: Fri, 8 Jan 1999 13:06:03 +1100
Message-Id: <199901080206.NAA01553@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: bh40@calva.net
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <19990107125944.017660@mail.mipsys.com> (message from Benjamin
	Herrenschmidt on Thu, 7 Jan 1999 12:59:44 +0100)
Subject: Re: Great IDE perf (WAS: Strange PMAC IDE performance)
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <19990107125944.017660@mail.mipsys.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt <bh40@calva.net> wrote:

> Another question about IDE: Does someone have any info about IDE ZIP
> drives ? I received a mail from someone which is having all sorts of
> trouble with a ZIP in the expansion bay. Looks like the beast is not
> correctly answering ATAPI commands sent by the driver (yeah, ATAPI, I
> thought a ZIP would be plain IDE or floppy-IDE but apparently, his drive
> is recognized as an ATAPI one).

I have an ide zip drive on my desktop G3, which appears as an ATAPI
floppy drive.  It works fine.  So it's going to take some digging to
find out why the expansion bay ZIP doesn't work. :-(

Paul.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
