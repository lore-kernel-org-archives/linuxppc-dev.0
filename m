From: Benjamin Herrenschmidt <benh@mipsys.com>
To: Gwyn Judd <b.judd@xtra.co.nz>,
        LinuxPPC Developers List
 <linuxppc-dev@lists.linuxppc.org>
Subject: Re: seemingly random lock-up with kernel 2.2.17p7
Date: Wed, 5 Jul 2000 16:26:40 +0200
Message-Id: <20000705142640.11467@mailhost.mipsys.com>
In-Reply-To: <20000706013650.A2546@thislove.dyndns.org>
References: <20000706013650.A2546@thislove.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>This has me puzzled. I'm not sure if it is a kernel panic or just X
>freezing since it never leaves anything in the logs. Has anyone had this
>problem? It seems to happen most often when I am listening to mp3's
>although it has happened a few times while it was just sitting there
>doing nothing.
>
>Also I am using BootX. Someone mentioned that the kernel is unreliable
>with BootX. I have not experienced any problems (barring the one that I
>mentioned) with it. What sorts of things are likely to happen? What is
>the upgrade process like to go to one of the newer bootloaders?

yaboot is only useful if you have a newworld mac.

Did you try killing the X server (ctrl-command-option-backspace) ? Does
it work ?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
