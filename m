Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vRWCC1Mg7zDq8X
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 15:40:23 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Joe Perches <joe@perches.com>, Anatolij Gustschin <agust@denx.de>,
 Scott Wood <oss@buserror.net>, Kumar Gala <galak@kernel.crashing.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Geoff Levand <geoff@infradead.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/35] powerpc: Convert remaining uses of pr_warning to
 pr_warn
In-Reply-To: <37c7a30a9666c203b7fce26da1c489e8e33f241e.1487314667.git.joe@perches.com>
References: <cover.1487314666.git.joe@perches.com>
 <37c7a30a9666c203b7fce26da1c489e8e33f241e.1487314667.git.joe@perches.com>
Date: Mon, 20 Feb 2017 15:40:19 +1100
Message-ID: <87wpclh3v0.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Joe Perches <joe@perches.com> writes:

> To enable eventual removal of pr_warning
>
> This makes pr_warn use consistent for arch/powerpc
>
> Prior to this patch, there were 36 uses of pr_warning and
> 217 uses of pr_warn in arch/powerpc
>
> Signed-off-by: Joe Perches <joe@perches.com>

Can I take this via the powerpc tree, or do you want to merge them as a
series?

cheers
