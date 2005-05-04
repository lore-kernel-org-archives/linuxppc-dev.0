Return-Path: <wrobell@pld-linux.org>
Received: from borg (83-70-79-142.b-ras1.srl.dublin.eircom.net [83.70.79.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5CDB3679E8
	for <linuxppc-dev@ozlabs.org>; Wed,  4 May 2005 20:50:04 +1000 (EST)
Received: from wrobell by borg with local (Exim 4.50) id 1DTH8u-0001rC-7p
	for linuxppc-dev@ozlabs.org; Wed, 04 May 2005 11:30:12 +0100
Date: Wed, 4 May 2005 11:30:12 +0100
From: wrobell <wrobell@pld-linux.org>
To: linuxppc-dev@ozlabs.org
Message-ID: <20050504103012.GA6851@borg>
References: <1113184854.9567.522.camel@gaston>
	<20050411101853.7f0e9385@colin.toulouse>
	<1113208474.8933.12.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1113208474.8933.12.camel@gaston>
Subject: Re: [PATCH] pmac: Improve sleep code of tumbler driver
Reply-To: wrobell <wrobell@pld-linux.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 11, 2005 at 06:34:34PM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2005-04-11 at 10:18 +0200, Colin Leroy wrote:
> > On Mon, 11 Apr 2005 12:00:54 +1000
> > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > 
> > > This patch (applies on top of my previous one adding support for newer
> > > machines) improves the behaviour of the "tumbler/snapper" driver used
> > > on newer PowerMacs during sleep. It properly set the HW mutes to shut
> > > down amplifiers and does an analog shutdown of the codec. That might
> > > improve power consumption during sleep on a number of machines.
> > 
> > I suppose it also fixes the occasionnal loud static noise that
> > sometimes at wakeup, for example on iBook G4s. Good :)
> 
> I don't know, tell me. I didn't know about this problem.
Point 3 in
http://lists.debian.org/debian-powerpc/2004/11/msg00383.html
:-)

Anyway, now there is no distortion/noise at sleep/wakeup (linus git tree).
Thanks for your great work!

Regards,

    wrobell <wrobell@pld-linux.org>
