Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by ozlabs.org (Postfix) with ESMTP id 03080DDFDF
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 08:19:29 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so1910184wag
	for <linuxppc-dev@ozlabs.org>; Mon, 08 Oct 2007 15:19:28 -0700 (PDT)
Message-ID: <fa686aa40710081519y5a0ebfeele46f41d540d7ecd3@mail.gmail.com>
Date: Mon, 8 Oct 2007 16:19:28 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH] Eval boards should not need to mess with ROOT_DEV
In-Reply-To: <200710082357.13144.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071008151254.7777.38512.stgit@trillian.cg.shawcable.net>
	<fa686aa40710081203k13f921dcm4542299c0ecb401@mail.gmail.com>
	<fa686aa40710081406w4aa751ewddb6a164bc070871@mail.gmail.com>
	<200710082357.13144.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/8/07, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 08 October 2007, Grant Likely wrote:
> > Oh, and cell does too. Geoff, does cell support really need to do this:
> > (in cell/setup.c and celleb/setup.c).
> > if (ROOT_DEV == 0) {
> > printk("No ramdisk, default root is /dev/hda2\n");
> > ROOT_DEV = Root_HDA2;
> > }
> >
> > If not; I'll spin a patch to drop it.
>
> Cell certainly doesn't need this, I believe this is an artifact from
> copying from pseries, so please kill it when you do the patch.

Cool; Looks like I'm killing it from all platforms except powermac.
Rolling patch now...

Cheers,
g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
