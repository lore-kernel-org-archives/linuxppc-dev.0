Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 88EF9DDE41
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 11:00:10 +1000 (EST)
Date: Thu, 3 Jul 2008 17:59:32 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: michael@ellerman.id.au
Subject: Re: [Bugme-new] [Bug 11027] New: random forward time jumps
Message-Id: <20080703175932.53ec7151.akpm@linux-foundation.org>
In-Reply-To: <1215132417.7849.2.camel@localhost>
References: <bug-11027-10286@http.bugzilla.kernel.org/>
	<20080702110614.4bd45cce.akpm@linux-foundation.org>
	<1215132417.7849.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 04 Jul 2008 10:46:57 +1000 Michael Ellerman <michael@ellerman.id.au> wrote:

> On Wed, 2008-07-02 at 11:06 -0700, Andrew Morton wrote:
> > On Wed,  2 Jul 2008 10:49:59 -0700 (PDT) bugme-daemon@bugzilla.kernel.org wrote:
> > 
> > > http://bugzilla.kernel.org/show_bug.cgi?id=11027
> > 
> > Hopefully someone in ppc land has set a watch on
> > platform_ppc-32@kernel-bugs.osdl.org?
> > 
> > If not, please go to http://bugzilla.kernel.org/userprefs.cgi?tab=email
> > and enter platform_ppc-32@kernel-bugs.osdl.org into the "Users to watch:"
> > box.
> 
> Is there a 64-bit equivalent? The obvious address didn't work.

Nope, the only account matching .*ppc.* and .*power.* is
platform_ppc-32@kernel-bugs.osdl.org.  (I have elevated bugzilla perms
so I can can query the users list) (everyone should have this - it's
handy).

There is a category "Platform Specific/Hardware"/PPC-64.  Those go to
anton@samba.org.

There is a category "Platform Specific/Hardware"/PPC-62.  Those go to
platform_ppc-32@kernel-bugs.osdl.org.

So setting a watch on both those accounts would suit.

Or you can just ignore it all.  I screen all bugzilla reports and will
ensure that suitable people know about them.
