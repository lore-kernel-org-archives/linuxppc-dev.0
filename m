Message-ID: <3C7FD350.F6FEC68F@mvista.com>
Date: Fri, 01 Mar 2002 14:15:28 -0500
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Tzahi Oved <tzahio@voltaire.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: ppcboot 1.1.4 & MPSC
References: <20083A3BAEF9D211BDB600805F8B14F3010A15AB@NTSERVER>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Where are you getting the source, linuxppc_2_4_devel or linux-galileo?
linux-galileo, I hope, because there is not mpsc driver in 2_4_devel.

Some gotcha:
1) you must change jumpers J42 & J43 to pins 2&3 for mpsc.
2) DINK will not put anything out the mpsc but will still run so you have to
wait some unknown amount of time before running your image (assuming you're
downloading with a bdi or something like that).
3) You have turned on the mpsc and turned off the 16550 in make config, right?

That's all I can think of right now?

Mark
--

Tzahi Oved wrote:

> Hi,
> I'm trying to work with the internal uart (MPSC) on the Galileo EVB64260
> board. When I set the definition CONFIG_MPSC in the EVB64260 config file
> (which supposed to set the terminal to work on the MPSC) I'm not getting any
> response on my console, do I need to configure anything else ?? any
> suggestions ?
>
> Thanks
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
