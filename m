In-Reply-To: <3843F20B.2C1616E@netx4.com>
Date: Tue, 30 Nov 1999 18:34:08 +0100
To: Dan Malek <dan@netx4.com>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: dmasound problems
Message-Id: <19991130183408.005713@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Nov 30, 1999, Dan Malek <dan@netx4.com> wrote:

>If you unload the module, I suspect console beep will go away
>as well???

Obiously, the beep goes away when the module is not here. However, I
managed to have the beep back as soon as the module is insmod'ed. (by
adding a 1ms delay after the awacs_write(0x6000)).


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
