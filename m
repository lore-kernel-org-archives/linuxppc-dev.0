In-Reply-To: <20040810073502.A32095@home.com>
References: <20040804093937.B12758@home.com> <285BFD4E-E638-11D8-852B-003065F9B7DC@embeddededge.com> <1092104488.2974.2.camel@c68.115.86.108.roc.mn.charter.com> <2D5216A6-EA93-11D8-899E-003065F9B7DC@embeddededge.com> <20040810073502.A32095@home.com>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <A0FA8EFF-EADD-11D8-899E-003065F9B7DC@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Josh Boyer <jwboyer@charter.net>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: Large TLBs on 40x
Date: Tue, 10 Aug 2004 10:57:41 -0400
To: Matt Porter <mporter@kernel.crashing.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Aug 10, 2004, at 10:35 AM, Matt Porter wrote:

> PPC40x no longer has this in 2.6.

Oh, I see now.

> So, to answer the original question, I would suggest a patch
> that that uses a 'noltlb' cmdline option,

Yes, that would work.

Thanks for the info.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
