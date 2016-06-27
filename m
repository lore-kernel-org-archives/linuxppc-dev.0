Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0117.hostedemail.com
 [216.40.44.117])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdQrx0KFszDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 20:58:08 +1000 (AEST)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave07.hostedemail.com (Postfix) with ESMTP id E6AFF11B0BA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 10:51:43 +0000 (UTC)
Message-ID: <1467024695.1847.87.camel@perches.com>
Subject: Re: powerpc/fadump: trivial fix of spelling mistake, clean up message
From: Joe Perches <joe@perches.com>
To: Colin Ian King <colin.king@canonical.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Jiri Kosina <trivial@kernel.org>, Rasmus
 Villemoes <linux@rasmusvillemoes.dk>,  Andrew Morton
 <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Date: Mon, 27 Jun 2016 03:51:35 -0700
In-Reply-To: <5771021E.3050305@canonical.com>
References: <3rcf3g63Wnz9s5Q@ozlabs.org> <5771021E.3050305@canonical.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-06-27 at 11:38 +0100, Colin Ian King wrote:
> On 26/06/16 05:19, Michael Ellerman wrote:
> > On Fri, 2016-24-06 at 17:43:00 UTC, Colin King wrote:
[]
> > > trivial fix to spelling mistake "rgistration" and minor clean up
> > > of the printk error message
> > Can you also:
> >  - use pr_err()
> >  - unsplit the message, ie. keep the string all on one line.
> I can unsplit the string, but checkpatch will complain about that, so
> I'm not sure if that's preferred or not.
> 
> WARNING: line over 80 characters

If the statement is wrapped after the format,
then checkpatch shouldn't complain.

	pr_err("Failed to invalidate firmware-assisted dump registration. Unexpected error (%d).\n",
	       rc);
