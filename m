In-Reply-To: <03E3E0690542D211A1490000F80836F4877DEC@zcard00f.ca.nortel.com>
Date: Tue, 13 Apr 1999 21:28:35 +0200
To: Jim Somerville <somer@nortelnetworks.com>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: quik vs. bootx
Message-Id: <19990413212835.023110@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Apr 13, 1999, Jim Somerville <somer@nortelnetworks.com> wrote:

>None of my systems have MacOS on them...I'm using quik.  I have no desire
>to reinstall MacOS just so I can boot linux.  Will quik work with the 2.2
>kernel, or will I be screwed here?  I'm currently using 2.1.24 on all my
>systems.

This should be added to the FAQ... 

BootX is not meant to _replace_ quik. Since OF is not working well enough
on a lot of Macs, BootX may be your only choice, but if quik works for
you and you like it, then use it, it's hopefully still working. OF
booting is better from a "theorical" point of view ;-)

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
