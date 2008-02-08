Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id ED6A5DDEBC
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Feb 2008 05:22:15 +1100 (EST)
Date: Fri, 8 Feb 2008 12:23:43 -0600
From: Olof Johansson <olof@lixom.net>
To: Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH] Fix compilation of powerpc asm-offsets.c with old gcc
Message-ID: <20080208182343.GB10295@lixom.net>
References: <18347.34100.60973.215093@cargo.ozlabs.ibm.com>
	<alpine.LFD.1.00.0802071449240.2896@woody.linux-foundation.org>
	<20080208120623.3ad74e3a.pj@sgi.com>
	<20080208182154.GA10295@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080208182154.GA10295@lixom.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	tglx@linutronix.de, Linus Torvalds <torvalds@linux-foundation.org>,
	akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 08, 2008 at 12:21:54PM -0600, Olof Johansson wrote:
> On Fri, Feb 08, 2008 at 12:06:23PM -0600, Paul Jackson wrote:
> > Linus wrote:
> > > Please, when mentioning hex numbers, also do the one-liner shortlog.
> > > ...
> > > without _requiring_ people to be git users to get the gist of the 
> > > matter, ok?
> > 
> > 
> > Thanks for sticking up for us git-challenged contributors.
> > 
> > Can anyone point me at instructions providing the shortest
> > path for getting from one of those git hex numbers to the
> > log or change it represents, for non-git users?
> > 
> > Or do those instructions begin with a first step of:
> > 
> >   1. become a git user
> >   2. ...
> 
> Does this count?
> 
> 1. Go to http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git
> 2. Enter the SHA string in the 'search' field at the top right

Ack, that just found the commit that referred to it, not the original
one. My bad.

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=<hex value>

Will bring it up though.


-Olof
