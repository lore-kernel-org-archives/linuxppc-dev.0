Return-Path: <jwboyer@gmail.com>
Received: from mail-qy0-f21.google.com (mail-qy0-f21.google.com
	[209.85.221.21]) by ozlabs.org (Postfix) with ESMTP id 3BE0BDDDF5
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Dec 2008 10:22:52 +1100 (EST)
Received: by qyk14 with SMTP id 14so4515825qyk.9
	for <linuxppc-dev@ozlabs.org>; Mon, 01 Dec 2008 15:22:51 -0800 (PST)
Date: Mon, 1 Dec 2008 18:22:48 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Hollis Blanchard <hollis@penguinppc.org>
Subject: Re: [PATCH] powerpc: add 16K/64K pages support for the 44x PPC32
	architectures.
Message-ID: <20081201232248.GB15923@zod.rchland.ibm.com>
References: <1227829488-8260-1-git-send-email-yanok@emcraft.com>
	<fb412d760812011506x37339fddue100a144e585782e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fb412d760812011506x37339fddue100a144e585782e@mail.gmail.com>
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: wd@denx.de, Ilya Yanok <yanok@emcraft.com>, linuxppc-dev@ozlabs.org,
	Vladimir Panfilov <pvr@emcraft.com>, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 01, 2008 at 05:06:03PM -0600, Hollis Blanchard wrote:
>On Thu, Nov 27, 2008 at 5:44 PM, Ilya Yanok <yanok@emcraft.com> wrote:
>> This patch adds support for page sizes bigger than 4K (16K/64K) on
>> PPC 44x.
>> PGDIR table is much smaller than page in case of 16K/64K pages (512
>> and 32 bytes resp.) so we allocate PGDIR with kzalloc() instead of
>> __get_free_pages().
>> PTE table covers rather big memory area in case of 16K/64K pages
>> (32MB and 512MB resp.) so we can easily put FIXMAP and PKMAP in
>> area covered by one PTE table.
>
>Ben, you had some comments on the previous version of this patch. Have
>those been addressed to your satisfaction? If so, could you please
>queue this for 2.6.29?

Milton had some comments too.  And I'd also like to review it and add
and Acked-by since I'll be the one getting bug reports if it's broken :).

I've been sick for the past few days, but this is the first thing to
review on my list tomorrow.

josh
