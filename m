Subject: Re: OF properties access ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040119120621.GD18112@iliana>
References: <20040113114625.GA9294@iliana> <1074131387.818.43.camel@gaston>
	 <20040115074439.GB14039@iliana> <1074310140.8360.27.camel@gaston>
	 <20040118120722.GA4603@iliana> <1074468096.795.27.camel@gaston>
	 <20040118143225.GA6717@iliana> <1074502892.813.41.camel@gaston>
	 <20040119101728.GB18112@iliana> <1074512524.10581.20.camel@gaston>
	 <20040119120621.GD18112@iliana>
Content-Type: text/plain
Message-Id: <1074548161.12326.28.camel@gaston>
Mime-Version: 1.0
Date: Tue, 20 Jan 2004 08:36:02 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Doing only : np = find_type_devices("cpu"); worked fine. I guess this
> will catch any cpus in the system, and be ok. There are not yet
> multi-cpu pegasos boxes, so i think it is ok to just check the first CPU
> and enable the L2 cache there, i will make sure the OF of future
> multi-cpu systems will set the L2 cache properly.
>
> Or is it better to go for the first child of cpus ?

What you do should be fine.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
