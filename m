Date: Wed, 7 Mar 2001 00:23:13 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Brad Parker <brad@parker.boston.ma.us>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: asm/io.h; why does writel() write an le32 on ppc?
In-Reply-To: <200103062315.SAA01659@p2.parker.boston.ma.us>
Message-ID: <Pine.HPX.4.10.10103070022380.3942-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 6 Mar 2001, Brad Parker wrote:

>
> Sorry to be daft, but why does writel() write an le32 on the ppc?
>
> in asm/io.h it uses out_le32, unless the machine is an APUS, in which
> case it just writes big endian...
>
> (is PCI defined as little endian?)

Sadly, yes.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
