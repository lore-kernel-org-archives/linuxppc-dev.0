In-Reply-To: <v04011700b2bab10bde9f@[209.86.156.161]>
Date: Thu, 7 Jan 1999 21:15:51 +0100
To: linuxppc-dev@lists.linuxppc.org, "Timothy A. Seufert" <tas@mindspring.com>
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Great IDE perf (WAS: Strange PMAC IDE performance)
Message-Id: <19990107211551.009756@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jan 7, 1999, Timothy A. Seufert <tas@mindspring.com> wrote:

>It's "ohare-ata".  Should apply to any machine with the O'Hare I/O ASIC
>(which includes many (all?) of the desktop 603e PCI machines, not just the
>older PCI PowerBooks).

I'm a little bit afraid of enabling this for older machines blindly. I
think I'll do a patch that looks for a specific config option on the
command line until enough people have tested it. After all, this may put
user's datas at risk.

Until Paul finds a more clear meaning of all this, this option should
allow to test if the values we found in MacOS are fine for all machines.
I could add code to BootX that sends the current MacOS values to linux
but this would really be too hackish, I think.

I'll update my test kernel and patch set later tonight or tomorrow.

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
