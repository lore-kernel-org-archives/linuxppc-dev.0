Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9359F67B52
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Apr 2005 18:34:56 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Colin Leroy <colin@colino.net>
In-Reply-To: <20050411101853.7f0e9385@colin.toulouse>
References: <1113184854.9567.522.camel@gaston>
	<20050411101853.7f0e9385@colin.toulouse>
Content-Type: text/plain
Date: Mon, 11 Apr 2005 18:34:34 +1000
Message-Id: <1113208474.8933.12.camel@gaston>
Mime-Version: 1.0
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

On Mon, 2005-04-11 at 10:18 +0200, Colin Leroy wrote:
> On Mon, 11 Apr 2005 12:00:54 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > This patch (applies on top of my previous one adding support for newer
> > machines) improves the behaviour of the "tumbler/snapper" driver used
> > on newer PowerMacs during sleep. It properly set the HW mutes to shut
> > down amplifiers and does an analog shutdown of the codec. That might
> > improve power consumption during sleep on a number of machines.
> 
> I suppose it also fixes the occasionnal loud static noise that
> sometimes at wakeup, for example on iBook G4s. Good :)

I don't know, tell me. I didn't know about this problem.

> Btw, do you know where patches land in this time of SCM change, when
> it's not in -mm ?

-mm :) Linus didn't restart merging things yet.

Ben.
