Date: Thu, 25 Jan 2001 23:35:58 +0100 (MET)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: Gabriel Paubert <paubert@iram.es>
cc: Dan Malek <dan@mvista.com>, mgreer@mvista.com,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_HIGHMEM on PPC
In-Reply-To: <Pine.HPX.4.10.10101252142420.22074-100000@gra-ux1.iram.es>
Message-ID: <Pine.GSO.4.10.10101252326450.1114-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On Thu, 25 Jan 2001, Gabriel Paubert wrote:

> > Heh....64Gbyte is nothing, just a few more bits beyond 32....you
> > don't need 64-bits for this.  In fact, I had a revelation last
> > night where I thought we could even do this quite transparently
> > on PowerPCs with VSIDs or even context registers, anything that
> > implictly gives us a few more bits of virtual address.  Later
> > on that.....
>
> You've seen the light, yes it is the way to go at least on 6xx/7xx[x]...

Could someone enlighten me, too? :)

bye, Roman


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
