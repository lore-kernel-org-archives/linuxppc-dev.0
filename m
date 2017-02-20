Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0143.hostedemail.com
 [216.40.44.143])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vRWGk5lC9zDq8X
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 15:43:26 +1100 (AEDT)
Message-ID: <1487565799.2853.1.camel@perches.com>
Subject: Re: [PATCH 06/35] powerpc: Convert remaining uses of pr_warning to
 pr_warn
From: Joe Perches <joe@perches.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Anatolij Gustschin
 <agust@denx.de>,  Scott Wood <oss@buserror.net>, Kumar Gala
 <galak@kernel.crashing.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Geoff Levand
 <geoff@infradead.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Sun, 19 Feb 2017 20:43:19 -0800
In-Reply-To: <87wpclh3v0.fsf@concordia.ellerman.id.au>
References: <cover.1487314666.git.joe@perches.com>
 <37c7a30a9666c203b7fce26da1c489e8e33f241e.1487314667.git.joe@perches.com>
 <87wpclh3v0.fsf@concordia.ellerman.id.au>
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

On Mon, 2017-02-20 at 15:40 +1100, Michael Ellerman wrote:
> Joe Perches <joe@perches.com> writes:
> 
> > To enable eventual removal of pr_warning
> > 
> > This makes pr_warn use consistent for arch/powerpc
> > 
> > Prior to this patch, there were 36 uses of pr_warning and
> > 217 uses of pr_warn in arch/powerpc
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> 
> Can I take this via the powerpc tree, or do you want to merge them as a
> series?

Well, I expect it'd be better if you merge it.
