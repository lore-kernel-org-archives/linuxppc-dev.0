Date: Fri, 28 Apr 2000 09:47:20 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Michel Dänzer <daenzerm@student.ethz.ch>
cc: "W. Taylor Holliday" <wtholliday@ucdavis.edu>,
        Kostas Gewrgiou <gewrgiou@imbc.gr>, linuxppc-dev@lists.linuxppc.org
Subject: Re: XFree 4.0 dual monitor on AGP G4
In-Reply-To: <39092B2B.249FFC07@student.ethz.ch>
Message-ID: <Pine.LNX.4.10.10004280915030.10268-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > If I apply your patch and recompile, how should I modify the config file?
> > Get rid of all BusID's? Just for the second monitor?
>
> I suggest always giving all BusIDs, it doesn't hurt as long as BusID and fbdev
> match.

Meaning fb0 usually is the one with your consoles on it (unless you mapped
them to another one), the rest follows in order of the devices being
probed by the kernel. The ordering of devices is defined by the order the
*fb_init calls appear in the source, and the exact order is still being
worked on as far as I understood Geert.
I think there's no way to change the device ordering at boot time ...

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
