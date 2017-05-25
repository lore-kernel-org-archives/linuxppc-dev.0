Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wYj2Z4jkxzDqkh
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 May 2017 07:24:38 +1000 (AEST)
Date: Fri, 26 May 2017 07:24:37 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Abdul Haleem <abdhalee@linux.vnet.ibm.com>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, linux-kernel
 <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Jiri Kosina
 <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 sachinp <sachinp@linux.vnet.ibm.com>, Rob Landley  <rob@landley.net>,
 Andrew Morton  <akpm@linux-foundation.org>
Subject: Re: [linux-next] PPC Lpar fail to boot with error hid: module
 verification failed: signature and/or required key missing - tainting
 kernel
Message-ID: <20170526072437.46499fbd@canb.auug.org.au>
In-Reply-To: <8760gp9jjl.fsf@concordia.ellerman.id.au>
References: <1495700957.9020.43.camel@abdul.in.ibm.com>
 <8760gp9jjl.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On Thu, 25 May 2017 23:02:06 +1000 Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> It'll be:
> 
> ee35011fd032 ("initramfs: make initramfs honor CONFIG_DEVTMPFS_MOUNT")

And Andrew has asked me to drop that patch from linux-next which will
happen today.

-- 
Cheers,
Stephen Rothwell
