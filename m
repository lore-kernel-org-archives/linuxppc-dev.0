Return-Path: <geoff@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vRr9j6m1BzDqBv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 04:25:13 +1100 (AEDT)
Subject: Re: [PATCH 06/35] powerpc: Convert remaining uses of pr_warning to
 pr_warn
To: Joe Perches <joe@perches.com>, Anatolij Gustschin <agust@denx.de>,
 Scott Wood <oss@buserror.net>, Kumar Gala <galak@kernel.crashing.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <cover.1487314666.git.joe@perches.com>
 <37c7a30a9666c203b7fce26da1c489e8e33f241e.1487314667.git.joe@perches.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From: Geoff Levand <geoff@infradead.org>
Message-ID: <a453cca8-4c81-87da-d47d-5cded8ac4fea@infradead.org>
Date: Mon, 20 Feb 2017 09:25:04 -0800
MIME-Version: 1.0
In-Reply-To: <37c7a30a9666c203b7fce26da1c489e8e33f241e.1487314667.git.joe@perches.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/16/2017 11:11 PM, Joe Perches wrote:
> To enable eventual removal of pr_warning
> ---
>  arch/powerpc/platforms/ps3/device-init.c        | 14 +++++++-------
>  arch/powerpc/platforms/ps3/mm.c                 |  4 ++--
>  arch/powerpc/platforms/ps3/os-area.c            |  2 +-

PS3 parts look OK.

-Geoff
