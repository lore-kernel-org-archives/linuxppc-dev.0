Date: Sun, 18 Jan 2004 23:22:31 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: OF properties access ?
Message-ID: <20040118222231.GB11651@iliana>
References: <20040113114625.GA9294@iliana> <1074131387.818.43.camel@gaston> <20040115074439.GB14039@iliana> <1074310140.8360.27.camel@gaston> <20040118120722.GA4603@iliana> <1074468096.795.27.camel@gaston> <20040118143225.GA6717@iliana> <20040118145158.GA7011@iliana> <20040118150502.GA7255@iliana> <1074503117.814.46.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1074503117.814.46.camel@gaston>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jan 19, 2004 at 08:05:18PM +1100, Benjamin Herrenschmidt wrote:
>
> > Further tests show me that it is the if (l2cr == NULL) return; tests
> > which aborts the test.
> >
> > Any idea what is going on here. Clearly we did read the right cpus, but
> > it is not possible to read the "l2cr" property.
>
> I think you read the "cpus" parent node and not the child node of
> the CPU itself. You can always printk np->full_name to be sure.

Ok, will try. Thanks.

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
