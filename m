Return-Path: <heukelum@fastmail.fm>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by ozlabs.org (Postfix) with ESMTP id E8707DE19F
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 21:30:46 +1000 (EST)
Message-Id: <1208777445.6956.1248994497@webmail.messagingengine.com>
From: "Alexander van Heukelum" <heukelum@fastmail.fm>
To: "Alexander van Heukelum" <heukelum@fastmail.fm>, "Ingo Molnar"
	<mingo@elte.hu>, "Stephen Rothwell" <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
References: <20080421191231.41a34aef.sfr@canb.auug.org.au>
	<20080421095102.GB1666@elte.hu>
	<1208776790.4613.1248992953@webmail.messagingengine.com>
Subject: Re: linux-next: x86-latest/powerpc-next merge conflict
In-Reply-To: <1208776790.4613.1248992953@webmail.messagingengine.com>
Date: Mon, 21 Apr 2008 13:30:45 +0200
Cc: linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 21 Apr 2008 13:19:50 +0200, "Alexander van Heukelum"
<heukelum@fastmail.fm> said:
> On Mon, 21 Apr 2008 11:51:02 +0200, "Ingo Molnar" <mingo@elte.hu> said:
> > * Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > 
> > > Hi all,
> > > 
> > > Today's linux-next merge of the x86-latest tree got a conflict in 
> > > include/asm-powerpc/bitops.h between commit 
> > > cd008c0f03f3d451e5fbd108b8e74079d402be64 ("generic: implement __fls on 
> > > all 64-bit archs") from the x86-latest tree and commit 
> > > 9f264be6101c42cb9e471c58322fb83a5cde1461 ("[POWERPC] Optimize fls64() 
> > > on 64-bit processors") from the powerpc-next tree.  The fixup was not 
> > > quite trivial and is worth a look to see if I got it right.
> 
> [...]
> 
> I've tried to take a look if you got it right, but the linux-next tree
> on git.kernel.org is 5 days old. If that's the current state then it's
> not merged right ;).

And it just started showing the new version. The merge went fine.

> Greetings,
>     Alexander
> 
> > Paul, do you agree with those generic bitops changes? Just in case it's 
> > not obvious from previous discussions: we'll push them upstream via a 
> > separate pull request, not via usual x86.git changes. They originated 
> > from x86.git but grew into a more generic improvement for all. They sit 
> > in x86.git for tester convenience but are of course not pure x86 changes 
> > anymore.
> > 
> > 	Ingo
-- 
  Alexander van Heukelum
  heukelum@fastmail.fm

-- 
http://www.fastmail.fm - A fast, anti-spam email service.
