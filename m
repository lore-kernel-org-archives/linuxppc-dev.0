Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0146.hostedemail.com
 [216.40.44.146])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ywylg3jb3zDrWF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Dec 2017 22:49:02 +1100 (AEDT)
Message-ID: <1513079336.3036.40.camel@perches.com>
Subject: Re: powerpc: Use pr_warn instead of pr_warning
From: Joe Perches <joe@perches.com>
To: Michael Ellerman <patch-notifications@ellerman.id.au>, Anatolij
 Gustschin <agust@denx.de>, Scott Wood <oss@buserror.net>, Kumar Gala
 <galak@kernel.crashing.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>,  Paul Mackerras <paulus@samba.org>, Geoff
 Levand <geoff@infradead.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Tue, 12 Dec 2017 03:48:56 -0800
In-Reply-To: <3ywyXQ5lPJz9sBW@ozlabs.org>
References: <3ywyXQ5lPJz9sBW@ozlabs.org>
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

On Tue, 2017-12-12 at 22:39 +1100, Michael Ellerman wrote:
> On Tue, 2016-10-25 at 04:00:08 UTC, Joe Perches wrote:
> > At some point, pr_warning will be removed so all logging messages use
> > a consistent <prefix>_warn style.
> > 
> > Update arch/powerpc/
> > 
> > Miscellanea:
> > 
> > o Coalesce formats
> > o Realign arguments
> > o Use %s, __func__ instead of embedded function names
> > o Remove unnecessary line continuations
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> > Acked-by: Geoff Levand <geoff@infradead.org>
> 
> Applied to powerpc next, thanks.
> 
> https://git.kernel.org/powerpc/c/f2c2cbcc35d47f1471a04155ac3575

OK, thanks.

But perhaps a year+ patch latency is a bit extended?
