Return-Path: <rob@landley.net>
Received: from mail-oi0-x244.google.com (mail-oi0-x244.google.com
 [IPv6:2607:f8b0:4003:c06::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wYx1x6ZBzzDqNC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 May 2017 16:24:53 +1000 (AEST)
Received: by mail-oi0-x244.google.com with SMTP id w10so334831oif.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 May 2017 23:24:53 -0700 (PDT)
Subject: Re: [linux-next] PPC Lpar fail to boot with error hid: module
 verification failed: signature and/or required key missing - tainting kernel
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <1495700957.9020.43.camel@abdul.in.ibm.com>
 <8760gp9jjl.fsf@concordia.ellerman.id.au>
 <20170526072437.46499fbd@canb.auug.org.au>
Cc: Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org,
 Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 sachinp <sachinp@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>
From: Rob Landley <rob@landley.net>
Message-ID: <87a7e82d-0af5-7f9e-6bd6-7e28b238e866@landley.net>
Date: Fri, 26 May 2017 01:24:48 -0500
MIME-Version: 1.0
In-Reply-To: <20170526072437.46499fbd@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/25/2017 04:24 PM, Stephen Rothwell wrote:
> Hi Michael,
> 
> On Thu, 25 May 2017 23:02:06 +1000 Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> It'll be:
>>
>> ee35011fd032 ("initramfs: make initramfs honor CONFIG_DEVTMPFS_MOUNT")
>
> And Andrew has asked me to drop that patch from linux-next which will
> happen today.

What approach do the kernel developers suggest I take here?

I would have thought letting it soak in linux-next for a release so
people could fix userspace bugs would be the next step, but this sounds
like that's not an option?

Is the behavior the patch implements wrong?

Rob
