From: jcarr@mail.linuxppc.org
Date: Mon, 9 Oct 2000 18:00:14 -0400 (EDT)
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: call_prom & call_method_1
In-Reply-To: <19340903140124.17579@192.168.1.10>
Message-ID: <Pine.LNX.4.21.0010091758430.935-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >1) Does anyone know what other strings can be sent to call_prom besides
> >"getprop", "findpackage", "interpret"?
>
> claim, release, ... well, those are defined in the OF client interface
> spec of the OF standard. Firmorks has, I think, a separate book for them

Ah ha! That explains it - that's the one firmworks manual I don't have.
Jeff


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
