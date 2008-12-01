Return-Path: <slightlyunconventional@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.29])
	by ozlabs.org (Postfix) with ESMTP id BA7E3DDDDF
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Dec 2008 10:06:05 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so1023934ywh.39
	for <linuxppc-dev@ozlabs.org>; Mon, 01 Dec 2008 15:06:04 -0800 (PST)
Message-ID: <fb412d760812011506x37339fddue100a144e585782e@mail.gmail.com>
Date: Mon, 1 Dec 2008 17:06:03 -0600
From: "Hollis Blanchard" <hollis@penguinppc.org>
Sender: slightlyunconventional@gmail.com
To: "Ben Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: add 16K/64K pages support for the 44x PPC32
	architectures.
In-Reply-To: <1227829488-8260-1-git-send-email-yanok@emcraft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1227829488-8260-1-git-send-email-yanok@emcraft.com>
Cc: linuxppc-dev@ozlabs.org, dzu@denx.de, wd@denx.de,
	Vladimir Panfilov <pvr@emcraft.com>, Ilya Yanok <yanok@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 27, 2008 at 5:44 PM, Ilya Yanok <yanok@emcraft.com> wrote:
> This patch adds support for page sizes bigger than 4K (16K/64K) on
> PPC 44x.
> PGDIR table is much smaller than page in case of 16K/64K pages (512
> and 32 bytes resp.) so we allocate PGDIR with kzalloc() instead of
> __get_free_pages().
> PTE table covers rather big memory area in case of 16K/64K pages
> (32MB and 512MB resp.) so we can easily put FIXMAP and PKMAP in
> area covered by one PTE table.

Ben, you had some comments on the previous version of this patch. Have
those been addressed to your satisfaction? If so, could you please
queue this for 2.6.29?

-Hollis
