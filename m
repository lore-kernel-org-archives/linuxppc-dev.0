Subject: Re: OF properties access ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040119101728.GB18112@iliana>
References: <20040113114625.GA9294@iliana> <1074131387.818.43.camel@gaston>
	 <20040115074439.GB14039@iliana> <1074310140.8360.27.camel@gaston>
	 <20040118120722.GA4603@iliana> <1074468096.795.27.camel@gaston>
	 <20040118143225.GA6717@iliana> <1074502892.813.41.camel@gaston>
	 <20040119101728.GB18112@iliana>
Content-Type: text/plain
Message-Id: <1074512524.10581.20.camel@gaston>
Mime-Version: 1.0
Date: Mon, 19 Jan 2004 22:42:05 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> And indeed, the problem seems to be that i get /cpus, and not
> /cpus/PowerPC,74x7. I thought that the /cpus should give the cpu per
> default or something such. What should i do here, i can go look for a
> PowerPC,74x7, but the board can also come with other CPUs (the 750Cxe
> for now). Maybe i could remove the cpus checking code completely, and go
> looking for the cpu type directly.

For the "cpus" case, just get to the first child

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
