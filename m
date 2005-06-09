Return-Path: <glikely@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.200])
	by ozlabs.org (Postfix) with ESMTP id A10EB67B3D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Jun 2005 04:34:42 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 57so349903wri
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 09 Jun 2005 11:34:40 -0700 (PDT)
Message-ID: <528646bc05060911346487aaf4@mail.gmail.com>
Date: Thu, 9 Jun 2005 12:34:39 -0600
From: Grant Likely <glikely@gmail.com>
To: Mark Chambers <markc@mail.com>
In-Reply-To: <00b701c56d07$e3b166a0$0301a8c0@chuck2>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20050609135509.AD5C2C1512@atlas.denx.de>
	<00b701c56d07$e3b166a0$0301a8c0@chuck2>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC52xx: sysfs failure on adding new device driver
Reply-To: Grant Likely <glikely@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 6/9/05, Mark Chambers <markc@mail.com> wrote:
> Sylvain:
> > btw, if not yet integrated you should send your patch to Wolfang, he's
> > the one maintaining that tree.
>=20
> Wolfgang:
> > I've seen the patch, but did not decide yet what to do with it.  Many
> > drivers  don't  support  devfs  anyway, and in my opinion devfs makes
> > little sense in embedded systems anyway. Not to mention that it  will
> > officially  be removed from the kernel tree in less than 4 weeks from
> > now (see Documentation/feature-removal-schedule.txt).
>=20
> This is nonsense.  You know, when I made this patch I said
> to myself, "Self, you're wasting your time, these guys won't take patches
> from somebody they don't know"  But I thought it was enough of a
> no-brainer that it might go through.
>=20
> Seems I was wrong.
>=20
Don't take things too personally.  (I understand where you're coming
from; I'm virtually unknown around here also).  You have to remember
that devfs is pretty much considered to be a bastard stepchild and
there is a lot of negative opinion surrounding it.  Because of that it
is very hard to get *any* devfs patches to be considered.

Just posting your patch on the ML is important and valuable.  That
makes things easy when somebody else has the same problem.  I
certainly remember seeing your original post, and I made note of it
for if I ever see that problem.

Cheers,
g.
