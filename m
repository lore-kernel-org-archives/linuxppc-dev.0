In-Reply-To: <Pine.LNX.4.05.9901061455190.1311-100000@beer.pub.umich.edu>
Date: Thu, 7 Jan 1999 10:19:02 +0100
To: linuxppc-user@lists.linuxppc.org,
        LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>,
        satadru pramanik <satadru@umich.edu>
CC: Paul Mackerras <paulus@cs.anu.edu.au>
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: scsi hangs - SOLVED!
Message-Id: <19990107101902.021731@smtp.calvacom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jan 6, 1999, satadru pramanik <satadru@umich.edu> wrote:

>Ben's test kernel SOLVES the scsi hang problem I was having.  I can copy
>400+ MB files across the scsi happily.  Neither the mesh or aic7xxx seem
>to be complaining too much.  I do get a bunch of bad interrrupts under
>heavy stress though.  After 10 minutes of heavy disk activity on the
>adaptec 2940, my /proc/interrupts gave me this:

I didn't do anything special to fix them. I guess someone fixed something
in vger or in linux SCSI handling recently.

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
