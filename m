Subject: Re: Large TLBs on 40x
From: Josh Boyer <jwboyer@charter.net>
To: Dan Malek <dan@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Matt Porter <mporter@kernel.crashing.org>
In-Reply-To: <6D94E16A-EBAB-11D8-8ABE-003065F9B7DC@embeddededge.com>
References: <20040804093937.B12758@home.com>
	 <285BFD4E-E638-11D8-852B-003065F9B7DC@embeddededge.com>
	 <1092104488.2974.2.camel@c68.115.86.108.roc.mn.charter.com>
	 <2D5216A6-EA93-11D8-899E-003065F9B7DC@embeddededge.com>
	 <20040810073502.A32095@home.com>
	 <1092232201.32005.4.camel@c68.115.86.108.roc.mn.charter.com>
	 <6D94E16A-EBAB-11D8-8ABE-003065F9B7DC@embeddededge.com>
Content-Type: text/plain
Message-Id: <1092247113.32112.20.camel@c68.115.86.108.roc.mn.charter.com>
Mime-Version: 1.0
Date: Wed, 11 Aug 2004 12:58:33 -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 2004-08-11 at 10:30, Dan Malek wrote:
> On Aug 11, 2004, at 9:50 AM, Josh Boyer wrote:
>
> > Hm...  like this?  Against 2.6.8-rc4.
>
> Does it work the way you want it now?

Yep, tested it on my board.  It's not the end goal I am looking for, but
it's a good starting point.

Basically, what I would like to get eventually is large TLBs + protected
kernel text pages.  Like you and Matt pointed out, there are issues with
that.  If it can't be done, then at least I can use this patch to
protect the kernel text pages easily.  Sometimes protection is more
important than performance.  Especially when I am hacking on stuff ;).

Thanks for the help.

josh


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
