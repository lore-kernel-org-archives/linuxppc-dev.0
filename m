In-Reply-To: <9902151757.AA75924@marc.watson.ibm.com>
Date: Mon, 15 Feb 1999 19:20:22 +0100
To: David Edelsohn <dje@watson.ibm.com>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: bootstrap stuffs
Message-Id: <19990215192022.006915@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Feb 15, 1999, David Edelsohn <dje@watson.ibm.com> wrote:

>	As Gabriel correctly explained, a "sync" instruction may be
>necessary before interrupts are enabled if some off-chip operation, like
>modifying an interrupt controller on the bus, was performed.  That is
>because of the bus operations which need to complete before interrupts can
>be enabled, not because of the enabling itself.

Yep, I knew this case, the sync after switching them OFF was just a
paranoid move on my part. Thanks for the tips.

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
