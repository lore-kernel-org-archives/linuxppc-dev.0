Date: Tue, 23 Nov 1999 13:21:16 -0700
From: Cort Dougan <cort@fsmlabs.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org,
        paulus@linuxcare.com
Subject: Re: bootloader & head.S weirdness (patch)
Message-ID: <19991123132116.A17270@hq.fsmlabs.com>
References: <19991123121629.A16956@hq.fsmlabs.com> <Pine.LNX.4.05.9911232115090.12629-100000@callisto.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.05.9911232115090.12629-100000@callisto.of.borg>; from Geert Uytterhoeven on Tue, Nov 23, 1999 at 09:16:38PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


} No we don't. The structure isn't that large, and the kernel is padded to a multiple
} of the page size anyway (the structure is after the kernel in memory).
} 
} Gr{oetje,eeting}s,
} P.S. How much Belgian Beer do I have to send you to convince you to put your
}      comments _below_ the text you quote, like all other people do? ;-)

If you send me Juliper (I think that was the one I had) just one will do :)

I'm putting some of those changes in for the m68k-style bootloader info
right now.  I'll have it in the main 2.3.x tree shortly.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
