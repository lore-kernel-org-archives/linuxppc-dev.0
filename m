Message-ID: <38C932F4.BD241CA9@erols.com>
Date: Fri, 10 Mar 2000 12:37:57 -0500
From: Nelson Abramson <pogtal@erols.com>
MIME-Version: 1.0
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: aty128fb does not work in newer sawtooth machines
References: <v03110700b4eed612282b@[129.100.29.243]>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Kevin B. Hendricks" wrote:

> If you however try anything else at higher depths you end up with a screen
> that is split into 3 vertical panes that make it impossible to use.
> <snip>
> The same problems exist in both Xpmac and XFree86 3.9.18.

The problems exist on sawtooths, imacs (and I think ibooks).

The problem exists in the console too, so I think it has to do w/ the kernel
ati128fb driver rather than the X server.

Waiting hopefully for a solution
--Nelson Abramson

--
Shouldn't people be arrested and persecuted for engaging in their
constitutional rights?  http://www.opendvd.org


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
