Date: Mon, 19 Jan 2004 13:06:21 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: OF properties access ?
Message-ID: <20040119120621.GD18112@iliana>
References: <20040113114625.GA9294@iliana> <1074131387.818.43.camel@gaston> <20040115074439.GB14039@iliana> <1074310140.8360.27.camel@gaston> <20040118120722.GA4603@iliana> <1074468096.795.27.camel@gaston> <20040118143225.GA6717@iliana> <1074502892.813.41.camel@gaston> <20040119101728.GB18112@iliana> <1074512524.10581.20.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1074512524.10581.20.camel@gaston>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jan 19, 2004 at 10:42:05PM +1100, Benjamin Herrenschmidt wrote:
>
> > And indeed, the problem seems to be that i get /cpus, and not
> > /cpus/PowerPC,74x7. I thought that the /cpus should give the cpu per
> > default or something such. What should i do here, i can go look for a
> > PowerPC,74x7, but the board can also come with other CPUs (the 750Cxe
> > for now). Maybe i could remove the cpus checking code completely, and go
> > looking for the cpu type directly.
>
> For the "cpus" case, just get to the first child

Doing only : np = find_type_devices("cpu"); worked fine. I guess this
will catch any cpus in the system, and be ok. There are not yet
multi-cpu pegasos boxes, so i think it is ok to just check the first CPU
and enable the L2 cache there, i will make sure the OF of future
multi-cpu systems will set the L2 cache properly.

Or is it better to go for the first child of cpus ?

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
