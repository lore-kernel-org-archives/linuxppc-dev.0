Subject: Re: controlfb and X
To: mlan@cpu.lu
Date: Mon, 6 Nov 2000 23:05:45 -0800 (PST)
Cc: bob@kunk.jriver.com, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200011062245.XAA00760@piglet.grunz.lu> from "Michel Lanners" at Nov 06, 2000 11:44:58 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20001107070546.08EF32B54A@marcus.pants.nu>
From: flar@pants.nu (Brad Boyer)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Lanners wrote:
>
>
> On   5 Nov, this message from Robert E Brose II echoed through cyberspace:
> > The problem is that the controlfb driver doesn't recognize more than
> > 2 megs of vram. This particular Mac 7500 has 4 megs installed which
> > works perfectly in MacOS.
>
> Strange. It should detect 4 meg in 2.2 kernels; but maybe not 2.4
> kernels.
>

There's been a long standing issue on detecting the full 4M on controlfb
that regularly pops up. I happen to have a 7600 with the video upgraded to
4M, so I've been interested in this as well. I've seen several patches
float over the list, and I don't think any of them actually worked for
everyone. I believe the conclusion was that control just didn't act the
same on every machine. I suspect that if you look back through the list
archives, you'll find lots of discussion on this topic.

	Brad Boyer
	flar@pants.nu

P.S.: Try the following search on lists.linuxppc.org in linuxppc-dev:

controlfb;patch;detect


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
