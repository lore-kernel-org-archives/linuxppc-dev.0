In-Reply-To: <Pine.LNX.3.95.990220154008.23593A-100000@pacific.pht.com>
Date: Sun, 21 Feb 1999 13:51:19 +0100
To: Brad Midgley <brad@pht.com>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: 601 vs head.S
Message-Id: <19990221135119.027203@smtp.calvacom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Feb 20, 1999, Brad Midgley <brad@pht.com> wrote:

>without patch: 
>
>Welcome to Linux, kernel 2.2.1
><hang>
>
>with patch:
>
>Welcome to Linux, kernel 2.2.1
>started at ...
>linked at ...
>fb at...
>MSR ...
><hang>

Are you sure that the patch you copied is the only difference between
those two kernels ? I mean, the first text used to be printed by prom.c
until I changed it to the second one with my latest patch (the one that
goes with BootX 1.0.2x)

In both cases, you hang after the early init and before the framebuffer
is really initialized.


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
