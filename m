In-Reply-To: <19991006182556.021225@mailhost.mipsys.com>
Date: Wed, 6 Oct 1999 18:50:07 +0200
To: toe@ofey.inetnebr.com
CC: Paul.Mackerras@cs.anu.edu.au, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: update on macserial/DMA
Message-Id: <19991006185007.004858@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Oct 6, 1999, Benjamin Herrenschmidt <bh40@calva.net> wrote:

>I beleive this could be acheived by changing line 2404 to pass
>zs_channels_found-1. Not pretty but not less than my fix anyway... The
>fake zs_soft exist only because of the assumption zs_channel[i] matches
>zs_soft[i], I didn't take time to check if this assumption exist only in
>the probe code or not. I'll try to do something better next week-end if I
>find some spare time.

Of course we must do this only when there's fake channel...

-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
