Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DF9B1B6FB6
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  4 Jun 2011 20:29:53 +1000 (EST)
Subject: Re: [PATCH] Add cpufreq driver for Momentum Maple boards
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
In-Reply-To: <BANLkTik6Ln1JGmN7isQ1tWPAf0upzHMvkg@mail.gmail.com>
References: <1305973726-28006-1-git-send-email-dbaryshkov@gmail.com>
	<BANLkTikGyV8aG1twBt7Jt_=j-fSBDiGzAg@mail.gmail.com>
	<BANLkTik6Ln1JGmN7isQ1tWPAf0upzHMvkg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 04 Jun 2011 20:29:41 +1000
Message-ID: <1307183381.23876.27.camel@pasglop>
Mime-Version: 1.0
Cc: Dave Jones <davej@redhat.com>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.ozlabs.org, cpufreq@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2011-06-04 at 13:00 +0400, Dmitry Eremin-Solenikov wrote:
> On 5/30/11, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> wrote:
> > Hello,
> >
> > On 5/21/11, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> wrote:
> >> Add simple cpufreq driver for Maple-based boards (ppc970fx evaluation
> >> kit and others). Driver is based on a cpufreq driver for 64-bit powermac
> >> boxes with all pmac-dependant features removed and simple cleanup
> >> applied.
> >>
> >> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> >> ---
> >>  arch/powerpc/kernel/misc_64.S          |    4 +-
> >>  arch/powerpc/platforms/Kconfig         |    8 +
> >>  arch/powerpc/platforms/maple/Makefile  |    1 +
> >>  arch/powerpc/platforms/maple/cpufreq.c |  317
> >> ++++++++++++++++++++++++++++++++
> >>  4 files changed, 328 insertions(+), 2 deletions(-)
> >>  create mode 100644 arch/powerpc/platforms/maple/cpufreq.c
> >
> > What about this patch?
> 
> Pinging again. Any problems/comments/objections to this patch?

Well, obviously nobody had time to review it yet....

Cheers,
Ben.
