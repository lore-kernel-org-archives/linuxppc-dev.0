In-Reply-To: <1092246160.32112.5.camel@c68.115.86.108.roc.mn.charter.com>
References: <20040804093937.B12758@home.com> <285BFD4E-E638-11D8-852B-003065F9B7DC@embeddededge.com> <1092104488.2974.2.camel@c68.115.86.108.roc.mn.charter.com> <2D5216A6-EA93-11D8-899E-003065F9B7DC@embeddededge.com> <20040810073502.A32095@home.com> <1092232201.32005.4.camel@c68.115.86.108.roc.mn.charter.com> <20040811084511.A8378@home.com> <1092246160.32112.5.camel@c68.115.86.108.roc.mn.charter.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8B62584B-EBC2-11D8-8ABE-003065F9B7DC@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Matt Porter <mporter@kernel.crashing.org>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: Large TLBs on 40x
Date: Wed, 11 Aug 2004 14:16:20 -0400
To: Josh Boyer <jwboyer@charter.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Aug 11, 2004, at 1:42 PM, Josh Boyer wrote:

> Yep, fixed.  Thanks for the tips.

Although a single sentence, my last question was meant
to be serious.  The changes here look reasonable, but
does the behavior change to be what you want to see?
What happens if you configure with/without KGDB
enabled (since this affects protection attributes)?

As a maintainer, I just can't accept a code patch without
documentation of the problem and that it is corrected.
I don't have the time to test all of these conditions before
pushing patches to the source tree, that's _your_ job :-)

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
