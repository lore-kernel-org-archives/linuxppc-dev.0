Return-Path: <jwboyer@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id 03239DDF03
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Sep 2008 06:09:54 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so187998yxg.39
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Sep 2008 13:09:53 -0700 (PDT)
Date: Thu, 11 Sep 2008 16:09:06 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Yuri Tikhonov <yur@emcraft.com>
Subject: Re: [PATCH] powerpc: add support for PAGE_SIZEs greater than 4KB for
Message-ID: <20080911200906.GD26684@yoda.jdub.homelinux.org>
References: <1221083587-8091-1-git-send-email-yanok@emcraft.com>
	<1221083587-8091-2-git-send-email-yanok@emcraft.com>
	<49c0ff980809110957h4b7b85d4ie39dbb27d1edbe39@mail.gmail.com>
	<1715327082.20080911221507@emcraft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1715327082.20080911221507@emcraft.com>
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org, prodyut hazarika <prodyuth@gmail.com>, wd@denx.de,
	dzu@denx.de, Ilya Yanok <yanok@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 11, 2008 at 10:15:07PM +0400, Yuri Tikhonov wrote:
>> I think this help should mention that for page size 256KB, you will
>> need to have a special version of binutils, since the ELF standard
>> mentions page sizes only upto 64KB.
>
> Right. We use ELDK-4.2 for compiling applications to be run on 256K
>PAGE_SIZE kernel. This toolchain includes necessary changes for
>ELF_MAXPAGESIZE in binutils/bfd/elf32-ppc.c.

Ok, but not everyone does.  And I think setting the page size to this
should be harder, maybe even dependent upon CONFIG_BROKEN.

I need to look over the patch a bit more, but some of the comments you've
already gotten seem valid.

josh
