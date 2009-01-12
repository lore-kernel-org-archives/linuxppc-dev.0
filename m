Return-Path: <jwboyer@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id 05B2ADDFF4
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 11:47:48 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so3279881ywh.39
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Jan 2009 16:47:47 -0800 (PST)
Sender: Josh Boyer <jwboyer@gmail.com>
Date: Sun, 11 Jan 2009 19:47:31 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc: rework dma-noncoherent to use generic
	vmap/vunmap functions
Message-ID: <20090112004731.GA21457@zod.rchland.ibm.com>
References: <1231505915-16082-1-git-send-email-yanok@emcraft.com>
	<fa686aa40901101631h2adee7e2j2e36624e368dc1f5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40901101631h2adee7e2j2e36624e368dc1f5@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, dzu@denx.de, wd@denx.de,
	Ilya Yanok <yanok@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jan 10, 2009 at 05:31:19PM -0700, Grant Likely wrote:
>On Fri, Jan 9, 2009 at 5:58 AM, Ilya Yanok <yanok@emcraft.com> wrote:
>> This patch rewrites consistent dma allocations support to use vmalloc
>> layer to allocate virtual memory space from vmalloc pool and get rid
>> of CONFIG_CONSISTENT_{START,SIZE}.
>
>Impressive patch.  I'll pull it into my tree and see how it works on
>4xx and 5200.

Doing my job for me now?  ;)

>BTW, you can drop all the defconfig updates in this patch.  The old
>config values will just disappear when 'make *_defconfig' is run.
>Putting them in the patch makes it far more likely that it won't apply
>at a later date.

Yes, totally agreed.  I update the 4xx defconfigs every release, so
they will get changed when I do that.

As Ben said, this is probably too late for .29, but definitely seems
like the right way to go.

josh
