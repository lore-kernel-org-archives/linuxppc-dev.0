Return-Path: <michael@ellerman.id.au>
Date: Wed, 10 Jul 2013 13:25:33 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Kevin Hao <haokexin@gmail.com>
Subject: Re: [PATCH 1/2] powerpc/math-emu: remove the dead code in math.c
Message-ID: <20130710032533.GA10374@concordia>
References: <1373420623-24869-1-git-send-email-haokexin@gmail.com>
 <1373420623-24869-2-git-send-email-haokexin@gmail.com>
 <20130710020132.GA7491@concordia>
 <20130710022307.GB361@pek-khao-d1.corp.ad.wrs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130710022307.GB361@pek-khao-d1.corp.ad.wrs.com>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 10, 2013 at 10:23:07AM +0800, Kevin Hao wrote:
> On Wed, Jul 10, 2013 at 12:01:33PM +1000, Michael Ellerman wrote:
> > On Wed, Jul 10, 2013 at 09:43:42AM +0800, Kevin Hao wrote:
> > > The math.c is only built when CONFIG_MATH_EMULATION is enabled.
> > > So we would never get into the case that CONFIG_MATH_EMULATION
> > > is not defined in this file.
> > 
> > Any idea why we have that there? ie. have the config symbols changed
> > over time or was this always dead code?
> 
> No idea. I tried to trace this before submitting the patch. But it has
> been there since the begin of the git history. So I just assume that it is
> always dead code. :-)

Yeah looks like it. Even in the git-huge tree I see it in the initial
commit.

You should say that in the commit message though. Otherwise it's not
clear if you're fixing a recent breakage or not.

cheers
