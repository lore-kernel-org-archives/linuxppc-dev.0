Return-Path: <prodyuth@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by ozlabs.org (Postfix) with ESMTP id 6CA96DDE07
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Oct 2008 02:54:55 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id m2so56763uge.14
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 08:54:52 -0700 (PDT)
Message-ID: <49c0ff980810170854jff48193r76a19c18497a1ec7@mail.gmail.com>
Date: Fri, 17 Oct 2008 08:54:52 -0700
From: "prodyut hazarika" <prodyuth@gmail.com>
To: "Ilya Yanok" <yanok@emcraft.com>
Subject: Re: [PATCH 1/2] powerpc: add 16K/64K pages support for the 44x PPC32
	architectures.
In-Reply-To: <1224123753-20907-2-git-send-email-yanok@emcraft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <1224123753-20907-1-git-send-email-yanok@emcraft.com>
	<1224123753-20907-2-git-send-email-yanok@emcraft.com>
Cc: linuxppc-dev@ozlabs.org, pvr@emcraft.com, dzu@denx.de, wd@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 15, 2008 at 7:22 PM, Ilya Yanok <yanok@emcraft.com> wrote:
> This patch adds support for page sizes bigger than 4K (16K/64K) on
> PPC 44x.
>

This patch looks good to me. Seems that all the review comments have
been incorporated.

Josh, it would be great if this patch is pulled into the mainline
kernel. I have seen significant performance improvement with RAID0/5
by using 64K pages.
