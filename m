Return-Path: <colin@colino.net>
Received: from paperstreet.colino.net (colino.net [213.41.131.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8B3E167B65
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Apr 2005 18:45:12 +1000 (EST)
Date: Mon, 11 Apr 2005 10:45:00 +0200
From: Colin Leroy <colin@colino.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20050411104500.00e6222e@colin.toulouse>
In-Reply-To: <1113208474.8933.12.camel@gaston>
References: <1113184854.9567.522.camel@gaston>
	<20050411101853.7f0e9385@colin.toulouse>
	<1113208474.8933.12.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: [PATCH] pmac: Improve sleep code of tumbler driver
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 11 Apr 2005 18:34:34 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Mon, 2005-04-11 at 10:18 +0200, Colin Leroy wrote:
> > On Mon, 11 Apr 2005 12:00:54 +1000
> > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > 
> > > This patch (applies on top of my previous one adding support for
> > > newer machines) improves the behaviour of the "tumbler/snapper"
> > > driver used on newer PowerMacs during sleep. It properly set the
> > > HW mutes to shut down amplifiers and does an analog shutdown of
> > > the codec. That might improve power consumption during sleep on a
> > > number of machines.
> > 
> > I suppose it also fixes the occasionnal loud static noise that
> > sometimes at wakeup, for example on iBook G4s. Good :)
> 
> I don't know, tell me. I didn't know about this problem.

It was reported here:
http://lists.debian.org/debian-powerpc/2005/01/msg00781.html

I didn't personnaly report it because it was hard to track it down;
it'd happen about once in twenty resumes (more often when you're in a
quiet place with strangers around, evidently, according to Murphy's
law), and nothing unusual appeared in dmesg (even with SND_DEBUG, which
doesn't debug much on ppc anyway). I just got used to mute the ibook
before sending it to sleep.

> > Btw, do you know where patches land in this time of SCM change, when
> > it's not in -mm ?
> 
> -mm :) Linus didn't restart merging things yet.

Ok, thanks. 
-- 
Colin
