Date: Tue, 15 Dec 1998 17:56:27 +0100
To: Liste LinuXppc/dev <linuxppc-dev@lists.linuxppc.org>,
        David Ray <daver@idiom.com>
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Complete fix for PB 2400 16-bit video problem
Message-Id: <19981215175627.030106@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Dec 13, 1998, David Ray <daver@idiom.com> wrote:

>It appears that the 16-bit in the console still has some problems. The color
>balance is off, but useable. Red is too bright and blue is too dim. I use a
>custom prompt that uses ansi colors so the color balance at the console
is more
>apparent on my system than on one that just uses white characters.

There is still a little issue with DIRECTCOLOR vs. TRUECOLOR and default
console color map, I think Tim will post a patch soon but if he can't,
I'll try a fix and send it to the list (I don't own a 2400 so I can't test).

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
