Return-Path: <jkacur@redhat.com>
Received: from mx02.colomx.prod.int.phx2.redhat.com (mx4-phx2.redhat.com
	[209.132.183.25]) by ozlabs.org (Postfix) with ESMTP id B74711007D2
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jun 2010 00:07:38 +1000 (EST)
Date: Fri, 11 Jun 2010 09:13:49 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <186819076.3013051276262029056.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1683892268.3009511276260172853.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>
Subject: Re: [PATCH 5/5] hvc_console: Fix race between hvc_close and hvc_remove
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Rusty Russell <rusty@rustcorp.com.au>, Clark Williams <williams@redhat.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linuxppc-dev@ozlabs.org, Amit Shah <amit.shah@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


----- "Stephen Rothwell" <sfr@canb.auug.org.au> wrote:

> Hi John,
> 
> On Thu, 10 Jun 2010 13:03:00 +0200 John Kacur <jkacur@redhat.com>
> wrote:
> >
> > From: Amit Shah <amit.shah@redhat.com>
> > 
> > Alan pointed out a race in the code where hvc_remove is invoked.
> The
> > recent virtio_console work is the first user of hvc_remove().
> 
> I am not sure where this comes from (linuxppc-dev only got 5/5) but
> this
> patch was applied to Linus' tree quite some time age (and fixed since
> then).
> 

Thanks for responding Stephen.

I was just listing patches that Thomas could potentially include
in the real-time kernel which is currently based on 2.6.33.5

I hadn't intended for git-send-email to cc everyone, but it
automatically included authors. sigh. I'll make sure to suppress that
next time.

John
