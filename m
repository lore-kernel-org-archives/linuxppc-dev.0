In-Reply-To: <19990716155150.A12541@drow.res.cmu.edu>
Date: Mon, 19 Jul 1999 15:18:21 +0200
To: Daniel Jacobowitz <drow@false.org>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: research for a new booting mechanism
Message-Id: <19990719151821.016699@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jul 16, 1999, Daniel Jacobowitz <drow@false.org> wrote:

>The question, it seems to me, is what sort of state the OS is in when
>this happens.  Is Open Firmware still mapped in, or does the Apple ROM
>unmap it?  It should be possible to use this in either case, although
>if it is unmapped, it would be more like running BootX (whose source I
>have not yet actually looked at).

Hum, the explanation looks stange. This boot mecanism is the "old" 68k
based mecanism, I don't really see how this could boot quik ppc code. I
beleive that using MacOS X System Disk just setup OF to boot quik, but I
don't think this is in any way related to those 68k stuffs.

I don't know if this boot-block mecanism is still supported, but it would
be interesting to try to put pieces of BootX there.


-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
