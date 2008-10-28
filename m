Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 7CD81DDE1F
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Oct 2008 03:56:26 +1100 (EST)
Date: Tue, 28 Oct 2008 19:56:23 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/4] of_gpio: Return GPIO flags from of_get_gpio()
Message-ID: <20081028165623.GA6686@oksana.dev.rtsoft.ru>
References: <Pine.LNX.4.64.0810241442240.3790@t2.domain.actdsltmp>
	<1224889741-4167-1-git-send-email-tpiepho@freescale.com>
	<20081028143933.GA18453@oksana.dev.rtsoft.ru>
	<fa686aa40810280753lc555683y5d32da678384438@mail.gmail.com>
	<20081028151659.GA26444@oksana.dev.rtsoft.ru>
	<fa686aa40810280842t36da3998j5f7ad22acf9f582c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <fa686aa40810280842t36da3998j5f7ad22acf9f582c@mail.gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Richard Purdie <rpurdie@rpsys.net>,
	Sean MacLennan <smaclennan@pikatech.com>,
	Trent Piepho <tpiepho@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 28, 2008 at 09:42:36AM -0600, Grant Likely wrote:
> On Tue, Oct 28, 2008 at 9:16 AM, Anton Vorontsov
> <avorontsov@ru.mvista.com> wrote:
> > On Tue, Oct 28, 2008 at 08:53:11AM -0600, Grant Likely wrote:
> >> That will deal with any merge window
> >> conflicts.
> >
> > This won't deal with build breakage because of API changes, which
> > means I can't submit FHCI driver to Greg, I have to wait for the
> > API changes applied.
> 
> Then we coordinate with Greg and make sure the fixup gets put in place
> before the window opens; either by bringing the patch in Ben's tree or
> by getting Greg to pull Ben's tree into -next.  This API change should
> not block Greg picking up the FHCI driver.  This is not an
> insurmountable problem.

Sounds complicated.

Ok, but if something will go wrong with the FHCI vs. of_get_gpio()
change, I'll just attribute the blame to you. :-))

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
