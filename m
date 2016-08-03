Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3v1T4MfVzDqQp
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Aug 2016 10:23:25 +1000 (AEST)
Date: Wed, 3 Aug 2016 10:23:24 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-next@vger.kernel.org, Fengguang Wu <fengguang.wu@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: powerpc allyesconfig / allmodconfig linux-next next-20160729 -
 next-20160729 build failures
Message-ID: <20160803102324.6372e66a@canb.auug.org.au>
In-Reply-To: <20160802220243.GK3296@wotan.suse.de>
References: <CAB=NE6U18jv89pxqAeZY8eTj44mq90kyXGaQO-108+ZMTyxQiQ@mail.gmail.com>
 <20160802215839.GA7383@roeck-us.net>
 <20160802220243.GK3296@wotan.suse.de>
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

Hi Luis,

On Wed, 3 Aug 2016 00:02:43 +0200 "Luis R. Rodriguez" <mcgrof@kernel.org> wrote:
>
> Thanks for the confirmation. For how long is it known this is broken?
> Does anyone care and fix these ? Or is this best effort?

This has been broken for many years :-(

I have a couple of times almost fixed it, but it requires that we
change from using "ld -r" to build the built-in.o objects and some
changes to the powerpc head.S code ... I will give it another shot now
that the merge window is almost over (and linux-next goes into its
quieter time).

-- 
Cheers,
Stephen Rothwell
