Date: Mon, 20 Mar 2000 01:20:32 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Florian Lohoff <flo@rfc822.org>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: PPC/MCA RS/6000 port ?
In-Reply-To: <20000319213603.A1365@paradigm.rfc822.org>
Message-ID: <Pine.HPX.4.10.10003200116330.28648-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 19 Mar 2000, Florian Lohoff wrote:

>
> Hi,
> i have a handful of PPC/MCA RS/6000 Machines around -
>
> Model 250 - PPC 601 66&80 Mhz, 2 MCA Slots, PizzaBox.
> Model (C20/C10) - PPC 601 or 604 depending on the CPU Module and ~4-5 MCA Slots
> Minitower.
>
> Is there anyone working on a port ? As i already read these machines
> are REALLY different from the later PPC/PCI machines and from the former
> Power/MCA machines.

This is a recurring question on this list which comes up every few months.
I don't think anybody is working on a port due to the lack of HW
documentation and the probably odd implementation (there must be reason
for the so called direct store segments supported by the MMU of early PPC
processors).

> Does anyone have Hardware documentation available or got those
> beasts to boot anything else than an AIX Kernel ?

I don't think so.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
