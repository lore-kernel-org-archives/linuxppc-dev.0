Return-Path: <amit.shah@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 86B51B7D43
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jun 2010 23:36:27 +1000 (EST)
Date: Fri, 11 Jun 2010 19:07:50 +0530
From: Amit Shah <amit.shah@redhat.com>
To: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 5/5] hvc_console: Fix race between hvc_close and hvc_remove
Message-ID: <20100611133750.GU20595@amit-laptop.redhat.com>
References: <1683892268.3009511276260172853.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>
	<186819076.3013051276262029056.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <186819076.3013051276262029056.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Clark Williams <williams@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
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

On (Fri) Jun 11 2010 [09:13:49], John Kacur wrote:
> 
> I was just listing patches that Thomas could potentially include
> in the real-time kernel which is currently based on 2.6.33.5

There's a fix to this patch: 320718ee074acce5ffced6506cb51af1388942aa
that you might want to include as well.

		Amit
