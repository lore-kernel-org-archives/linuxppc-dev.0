From: Benjamin Herrenschmidt <benh@mipsys.com>
To: Christof Petig <christof.petig@wtal.de>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.2.17pre9-ben1 gmac problems on iBook
Date: Wed, 5 Jul 2000 15:37:28 +0200
Message-Id: <20000705133728.28733@mailhost.mipsys.com>
In-Reply-To: <396201D1.B43A97F1@wtal.de>
References: <396201D1.B43A97F1@wtal.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>You're right.
>Strange though that BootX gives this kind of weird behaviour (2.2.15pre14
>works fine for me).
>I'll report about yaboot soon.

You "think" it worked right, but I'm pretty sure that if you do an
extensive memory testing, you'll discover that random bits of memory are
damaged and that the kernel is actually not fully reliable when booting
with BootX.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
