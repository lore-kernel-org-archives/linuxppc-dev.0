Message-ID: <3CF7F086.CA7EACD7@mvista.com>
Date: Fri, 31 May 2002 17:52:06 -0400
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: willy@synergymicro.com
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: GT64260 ethernet driver - long term stability?
References: <200205100459.XAA27925@lists.linuxppc.org> <3CF6C96E.BD1DAA3A@synergymicro.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Bill Fincke wrote:

> Has anyone exercised the gt64260_eth.c driver (from the MontaVista
> BK tree) for any length of time?  I ported it and have been using
> it successfully for several weeks, but find that it can't sustain
> continuous file transfers for more than a few hours.

I'm not all that surprised that you've run into something.  Both the
ethernet and mpsc (uart) drivers for the controllers on that bridge are
pretty much hacks.  They need to be rewritten at some point.  To be
honest, after looking at them, I'm surprised they work as well as they
do.  Its a project just waiting for a volunteer just like you!!   ;)

Mark


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
