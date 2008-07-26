Return-Path: <sam@ravnborg.org>
Received: from smtpout3.tre.se (smtpout3.tre.se [80.251.192.228])
	by ozlabs.org (Postfix) with ESMTP id A76B8DDED1
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 20:46:26 +1000 (EST)
Date: Sat, 26 Jul 2008 12:06:32 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: kbuild tree build failure
Message-ID: <20080726100631.GA3714@uranus.ravnborg.org>
References: <20080707184038.aaeb8d40.sfr@canb.auug.org.au>
	<20080725141330.c58e0a07.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080725141330.c58e0a07.sfr@canb.auug.org.au>
Cc: Milton Miller <miltonm@bga.com>, linuxppc-dev@ozlabs.org,
	linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 25, 2008 at 02:13:30PM +1000, Stephen Rothwell wrote:
> Hi Sam,
> 
> On Mon, 7 Jul 2008 18:40:38 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Today's linux-next build (powerpc ppc64_defconfig) failed like this:
> > 
> > arch/powerpc/platforms/cell/spu_base.c: In function '__spu_trap_data_seg':
> > arch/powerpc/platforms/cell/spu_base.c:194: error: duplicate case value
> > arch/powerpc/platforms/cell/spu_base.c:177: error: previously used here
> 
> This still fails in linux-next today.  We need some solution before you
> send these commits to Linus.
I removed the offending commits from kbuild-next before I
sent the pull request.
I will though revisit the issue after -rc1.

	Sam
