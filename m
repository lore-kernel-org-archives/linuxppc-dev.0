Date: Mon, 8 Jan 2001 09:32:04 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Iain Sandoe <iain@sandoe.co.uk>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: status of ppc support in official 2.4.0 or Alan's 2.4.0-ac1
Message-ID: <20010108093204.I19404@opus.bloom.county>
References: <20010108161159.46AB62EF98@apollo.valhalla.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010108161159.46AB62EF98@apollo.valhalla.net>; from iain@sandoe.co.uk on Mon, Jan 08, 2001 at 04:16:24PM +0000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jan 08, 2001 at 04:16:24PM +0000, Iain Sandoe wrote:
>
> Mon, Jan 8, 2001, Tom Rini wrote:
> > 2_4 is on the same port as where 2_3 used to be.  2_4 is once again working,
> > so everyone go and try that tree on your machine.
>
> so what's on the rsync linuxppc_2_3 ?

No idea.  It might be 2_4 it might not be. :)

> (for those of us who still haven't had time to tangle with bk ;-)
>
> and can I expect it to build?
> what state does it represent?
> (i.e. is it a continuation of the same tree - or a rebuild from the 2.4.0
> final)

The 2_4 tree is building.  If it's not building, report it here.
It represents what will someday get to Linus.  Hopefully sooner rather than
later.  It's a new tree which is the old tree.  Cort made a new one, called
2_4 and I put all of our changes from 2_3 back in.  It's based off of 2.4.0
final.

> is there any point trying kernel.org 2.4.0 final? (or ac3 - which I pulled
> last night)

No.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
