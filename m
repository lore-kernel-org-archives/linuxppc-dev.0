In-Reply-To: <1092247113.32112.20.camel@c68.115.86.108.roc.mn.charter.com>
References: <20040804093937.B12758@home.com> <285BFD4E-E638-11D8-852B-003065F9B7DC@embeddededge.com> <1092104488.2974.2.camel@c68.115.86.108.roc.mn.charter.com> <2D5216A6-EA93-11D8-899E-003065F9B7DC@embeddededge.com> <20040810073502.A32095@home.com> <1092232201.32005.4.camel@c68.115.86.108.roc.mn.charter.com> <6D94E16A-EBAB-11D8-8ABE-003065F9B7DC@embeddededge.com> <1092247113.32112.20.camel@c68.115.86.108.roc.mn.charter.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4A6BAC8D-EBC3-11D8-8ABE-003065F9B7DC@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Matt Porter <mporter@kernel.crashing.org>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: Large TLBs on 40x
Date: Wed, 11 Aug 2004 14:21:40 -0400
To: Josh Boyer <jwboyer@charter.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Aug 11, 2004, at 1:58 PM, Josh Boyer wrote:

> Yep, tested it on my board.  It's not the end goal I am looking for,
> but
> it's a good starting point.

Ummm...OK.

> Basically, what I would like to get eventually is large TLBs +
> protected
> kernel text pages.  Like you and Matt pointed out, there are issues
> with
> that.  If it can't be done, .....

It can be done, just not easily.  Requires boundary/alignment of
text/data
and set up of the large TLBs.  Then, there is the issue with wanting the
same feature with loadable modules......

> .......  Sometimes protection is more
> important than performance.  Especially when I am hacking on stuff ;).

Well, you have the option now.  Have fun!


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
