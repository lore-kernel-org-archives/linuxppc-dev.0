Date: Tue, 19 Sep 2000 20:31:24 +0200 (MET DST)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: Dan Malek <dan@mvista.com>
cc: paulus@linuxcare.com.au, Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
In-Reply-To: <39C77803.F182709E@mvista.com>
Message-ID: <Pine.GSO.4.10.10009192020500.4878-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

> OK.  On the 8xx, I currently rely on the effect that ioremap will
> map virt->phys 1:1 before the kernel VM is initialized.

I'm curious, what needs ioremap before the VM is ready?

> Mapping through BATs usually covers most of this, but more processors
> arriving (the IBM 4xx) don't have BATs either so we rely on page
> tables of some sort.

Shouldn't it be possible, to add such stuff directly to the hash table
and add the official mapping later?
BTW the whole mm stuff really needs a big cleanup, but I don't really want
to touch it, as I could only test this on my APUS machine, which has only
the CPU in common with the other machines.

bye, Roman


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
