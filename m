In-Reply-To: <1092104488.2974.2.camel@c68.115.86.108.roc.mn.charter.com>
References: <20040804093937.B12758@home.com> <285BFD4E-E638-11D8-852B-003065F9B7DC@embeddededge.com> <1092104488.2974.2.camel@c68.115.86.108.roc.mn.charter.com>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2D5216A6-EA93-11D8-899E-003065F9B7DC@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Matt Porter <mporter@kernel.crashing.org>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: Large TLBs on 40x
Date: Tue, 10 Aug 2004 02:04:44 -0400
To: Josh Boyer <jwboyer@charter.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Aug 9, 2004, at 10:21 PM, Josh Boyer wrote:

> I have some boards I could test such a patch on.  Or is it a case of
> "this isn't trivial to do"?

Ummmmm.....what are we talking about here?

Both MPC8xx, and IBM40x have configuration options for
pinning some (small) amount of kernel space.  You can choose
to enable this if you wish, I don't think it is normally enabled.
I've never found a benchmark that proved either was better,
but I left the code there for others to experiment with.

	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
