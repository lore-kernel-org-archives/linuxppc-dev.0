Date: Mon, 27 Nov 2000 16:34:24 +0100 (CET)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        debian-powerpc@lists.debian.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: apmd and other archs
In-Reply-To: <19341022082533.14985@192.168.1.2>
Message-ID: <Pine.LNX.4.10.10011271629590.19879-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >Result: The vanilla gnome battery_applet now works for me (TM).
>
> A better way would be to have the via-pmu driver asynchronously (via
> a timer) poll for state change and update some static status datas.
> This way, on core99, we can just disable the polling timer and rely
> on automatic notifications done by the hw. The /proc interface would
> then just output the last status.

Just as fine. What routine is processing the automatic notification, and
what does the data format look like? I guess /dev/pmu will have to return
buffered data as well on core99?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
