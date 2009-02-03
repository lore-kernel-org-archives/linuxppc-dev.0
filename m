Return-Path: <airlied@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id C20CBDDE22
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Feb 2009 19:39:05 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so656225yxg.39
	for <linuxppc-dev@ozlabs.org>; Tue, 03 Feb 2009 00:39:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1233609688.18767.118.camel@pasglop>
References: <20090202055559.8D600DDF51@ozlabs.org>
	<1233608464.4932.15.camel@gaiman> <1233609688.18767.118.camel@pasglop>
Date: Tue, 3 Feb 2009 18:39:03 +1000
Message-ID: <21d7e9970902030039n786b831dm4395b802e0c87b45@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm: Make drm_local_map use a resource_size_t offset
From: Dave Airlie <airlied@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Airlie <airlied@linux.ie>, Eric Anholt <eric@anholt.net>,
	dri-devel@lists.sf.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 3, 2009 at 7:21 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
>>
>> Could this comment instead be maybe:
>>
>> Because the kernel-userspace ABI is fixed at a 32-bit offset, while PCI
>> resources may live above that, we ignore the map offset for maps of type
>> _DRM_FRAMEBUFFER or _DRM_REGISTERS.  It is assumed that each driver will
>> have only one resource of each type.
>>
>> (I want to remember later what exact ABI problem was in question)
>
> Fair enough. I'll repost.
>

Don't worry I've applied the patches with Erics comment replacing your one.

All 3 are queued in drm-next.

Dave.

> Cheers,
> Ben.
>
>
> ------------------------------------------------------------------------------
> Create and Deploy Rich Internet Apps outside the browser with Adobe(R)AIR(TM)
> software. With Adobe AIR, Ajax developers can use existing skills and code to
> build responsive, highly engaging applications that combine the power of local
> resources and data with the reach of the web. Download the Adobe AIR SDK and
> Ajax docs to start building applications today-http://p.sf.net/sfu/adobe-com
> --
> _______________________________________________
> Dri-devel mailing list
> Dri-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/dri-devel
>
