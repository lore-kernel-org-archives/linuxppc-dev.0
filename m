Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 25308B7BEB
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Dec 2009 14:06:47 +1100 (EST)
Date: Fri, 4 Dec 2009 20:59:49 -0600
From: Olof Johansson <olof@lixom.net>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] MAINTAINERS: Add PowerPC patterns
Message-ID: <20091205025949.GA29554@lixom.net>
References: <20091202091951.5ec6bb83@hyperion.delvare>
	<1259894454.2076.1246.camel@pasglop>
	<20091204103434.0a754925@hyperion.delvare>
	<1259920775.2076.1273.camel@pasglop>
	<1259947019.22783.116.camel@Joe-Laptop.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1259947019.22783.116.camel@Joe-Laptop.home>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, LKML <linux-kernel@vger.kernel.org>,
	Jean Delvare <khali@linux-fr.org>, Paul Mackerras <paulus@samba.org>,
	Colin Leroy <colin@colino.net>, "Darrick J. Wong" <djwong@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 04, 2009 at 09:16:59AM -0800, Joe Perches wrote:
> On Fri, 2009-12-04 at 20:59 +1100, Benjamin Herrenschmidt wrote:
> > On Fri, 2009-12-04 at 10:34 +0100, Jean Delvare wrote:
> > > I've sent it to linuxppc-dev@ozlabs.org on October 14th. This is the
> > > address which is listed 22 times in MAINTAINERS. If it isn't correct,
> > > then please update MAINTAINERS.
> > No it's fine both shoul work. Your patches are there, just waiting for
> > me to pick them up, I was just firing a reminder to the rest of the CC
> > list :-) (and I do remember fwd'ing a couple of your patches to the
> > list, for some reason they didn't make it to patchwork back then, that
> > was a few month ago).
> > Anyways, I've been stretched thin with all sort of stuff lately, so bear
> > with me if I'm a bit slow at taking or testing stuff, I'm doing my best.
> 
> Adding patterns to the PowerPC sections of MAINTAINERS is useful.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Acked-by: Olof Johansson <olof@lixom.net>

There are a few other files under arch/powerpc that's not under platforms
that belongs to the pasemi code but it's not a big deal to not include
them. This goes most of the way.


-Olof
