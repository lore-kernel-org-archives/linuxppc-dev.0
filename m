In-Reply-To: <199901080206.NAA01553@tango.anu.edu.au>
Date: Fri, 8 Jan 1999 04:30:05 +0100
To: linuxppc-dev@lists.linuxppc.org, Paul.Mackerras@cs.anu.edu.au
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Great IDE perf (WAS: Strange PMAC IDE performance)
Message-Id: <19990108043005.022500@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jan 8, 1999, Paul Mackerras <paulus@cs.anu.edu.au> wrote:

>I have an ide zip drive on my desktop G3, which appears as an ATAPI
>floppy drive.  It works fine.  So it's going to take some digging to
>find out why the expansion bay ZIP doesn't work. :-(

Apparenlty, his ZIP is beeing recognized as a CDROM device, which is
obviously wrong. I'll dig around in the code and looks if I see something
obvious.


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
