Date: Mon, 2 Aug 2004 23:47:15 +0200
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: Adrian Cox <adrian@humboldt.co.uk>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] Workaround for 745x data corruption bug
Message-ID: <20040802214715.GB30047@pegasos>
References: <1091291276.987.57.camel@localhost> <410E85EE.8050707@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <410E85EE.8050707@mvista.com>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Aug 02, 2004 at 11:20:30AM -0700, Mark A. Greer wrote:
> Adrian Cox wrote:
>
> >Recently released errata documents show a new bug in all 745x family
> >processors. This can cause data corruption when memory is mapped
> >non-coherent and one of these conditions is true:
> >1) L2 hardware prefetch is enabled (as it is in Linux)
> >2) instructions and data are fetched from the same or adjacent cache
> >lines.
> >
> >The attached patch adds a workaround, by setting CPU_FTR_NEED_COHERENT
> >on all 745x processors.
> >
>
> Well that sucks (the bug, not the patch :).  Many people like to turn
> off coherency when using Marvell host bridges b/c they struggle
> performance-wise with coherency on (at least on some versions).
>
> One change to the patch, though.  According to the 7447/7457 errata doc,
> rev 1.2 doesn't have the bug.  The attached patch accounts for that.

Notice that there are rev 1.1 7447s around, and that benh's patch does include
support for both the 1.1 and the 1.2 ones.

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
