From: Benjamin Herrenschmidt <bh40@calva.net>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        <debian-powerpc@lists.debian.org>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: apmd and other archs
Date: Mon, 27 Nov 2000 15:53:49 +0100
Message-Id: <19341022082533.14985@192.168.1.2>
In-Reply-To: 
 <Pine.LNX.4.10.10011271404350.16628-100000@opal.biophys.uni-duesseldorf.de>
References: 
 <Pine.LNX.4.10.10011271404350.16628-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>My contribution to kernel bloat ... untested except on Lombard, the 3400
>code needs testing and perhaps some work. Overall the code looks pretty
>ugly, take it as a proof of concept only and improve as desired. Patch is
>against 2.2.18-stable, the proc_register probably needs changing for 2.4.
>
>Result: The vanilla gnome battery_applet now works for me (TM).

A better way would be to have the via-pmu driver asynchronously (via
a timer) poll for state change and update some static status datas.
This way, on core99, we can just disable the polling timer and rely
on automatic notifications done by the hw. The /proc interface would
then just output the last status.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
