In-Reply-To: <19990111042611.A152@gondolin>
Date: Mon, 11 Jan 1999 17:29:13 +0100
To: linuxppc-dev@lists.linuxppc.org, Ryan Nielsen <ran@krazynet.com>
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Linux-2.2.0-pre5 SMP broken on PReP?
Message-Id: <19990111172913.007726@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jan 11, 1999, Ryan Nielsen <ran@krazynet.com> wrote:

>it is crashing in kswapd, not the ncr driver.
>
>I got pre6 to work by reverse-patching the kswapd part of mm/vmscan.c down to
>pre4
>this is only needed for SMP...

Linus posted some messages about this on the kernel ML, pre-7 should fix
all that mess, the memory trashing may finally work fine after all ;-)

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
