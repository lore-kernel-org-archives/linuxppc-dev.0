Date: Wed, 11 Aug 2004 11:38:36 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
Cc: Josh Boyer <jwboyer@charter.net>,
	linuxppc-embedded@lists.linuxppc.org,
	Matt Porter <mporter@kernel.crashing.org>
Subject: Re: Large TLBs on 40x
Message-ID: <20040811113836.C8378@home.com>
References: <20040804093937.B12758@home.com> <285BFD4E-E638-11D8-852B-003065F9B7DC@embeddededge.com> <1092104488.2974.2.camel@c68.115.86.108.roc.mn.charter.com> <2D5216A6-EA93-11D8-899E-003065F9B7DC@embeddededge.com> <20040810073502.A32095@home.com> <1092232201.32005.4.camel@c68.115.86.108.roc.mn.charter.com> <20040811084511.A8378@home.com> <1092246160.32112.5.camel@c68.115.86.108.roc.mn.charter.com> <8B62584B-EBC2-11D8-8ABE-003065F9B7DC@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8B62584B-EBC2-11D8-8ABE-003065F9B7DC@embeddededge.com>; from dan@embeddededge.com on Wed, Aug 11, 2004 at 02:16:20PM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Aug 11, 2004 at 02:16:20PM -0400, Dan Malek wrote:
>
> On Aug 11, 2004, at 1:42 PM, Josh Boyer wrote:
>
> > Yep, fixed.  Thanks for the tips.
>
> Although a single sentence, my last question was meant
> to be serious.  The changes here look reasonable, but
> does the behavior change to be what you want to see?
> What happens if you configure with/without KGDB
> enabled (since this affects protection attributes)?

Well, we know what happens there.  The protection goes away since
we have code to ensure that kernel text is writeable when we have
any of the debuggers enabled...regardless of whether notlbs or
nobats is set.

> As a maintainer, I just can't accept a code patch without
> documentation of the problem and that it is corrected.
> I don't have the time to test all of these conditions before
> pushing patches to the source tree, that's _your_ job :-)

In any case, I've heard from folks that don't want large tlb
mappings in some cases, so this little unobtrustive option
has other uses.

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
