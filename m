In-Reply-To: <19991128154913.A15762@io.nu>
Date: Mon, 29 Nov 1999 00:06:45 +0100
To: Shaw Terwilliger <sterwill@io.nu>, paulus@linuxcare.com
CC: linuxppc-dev@lists.linuxppc.org, dan@netx4.com
From: BenH <bh40@calva.net>
Subject: Re: 2.3.30-pre3
Message-Id: <19991129000645.003441@smtp.calvacom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Nov 28, 1999, Shaw Terwilliger <sterwill@io.nu> wrote:

>I can make diffs if anyone wants them; I'm sure some other people would
>rather like to build from Paul's unstable tree.  :)  I'd been using
>his stable tree, but for the last 3 months, I can't boot one of his
>stable kernels without getting a machine check somewhere in init.
>The unstable ones have no problems with it, although my USB mouse seems
>to have stopped working... (so now I'm trying to make Xpmac use some
>keys to emulate mouse buttons, but they seem hard-coded, so it'll be
>a little harder than I thought).

Yes, please, send me your patches. Paul will be away for a few weeks and
I want to move all my patches (there are more coming ;) to 2.3.x asap.

BTW, dmasound is broken in Paul's current stable 2.2.14pre. I don't know
yet what's going on but it looks like the driver had major changes
(backported sound in from 2.3.x ?). I can't get any sound output on my
wallstreet anymore. I'll try to look into this next week.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
