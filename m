Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3qpm32zJzDrHn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Aug 2016 07:58:55 +1000 (AEST)
Date: Tue, 2 Aug 2016 14:58:39 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org,
 Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org,
 Fengguang Wu <fengguang.wu@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: powerpc allyesconfig / allmodconfig linux-next next-20160729 -
 next-20160729 build failures
Message-ID: <20160802215839.GA7383@roeck-us.net>
References: <CAB=NE6U18jv89pxqAeZY8eTj44mq90kyXGaQO-108+ZMTyxQiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAB=NE6U18jv89pxqAeZY8eTj44mq90kyXGaQO-108+ZMTyxQiQ@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 02, 2016 at 01:07:09PM -0700, Luis R. Rodriguez wrote:
> Are linux-next builds being tested for powerpc with allyesconfig and
> allmodconfig ? I have some changes I'm making and while debugging my
> build issues I decided to give a clean build a shot and see linux-next
> next-20160729 up to next-20160729 all have build failures without my
> changes. I get:
> 
> /opt/gcc-4.9.0-nolibc/powerpc64-linux/bin/powerpc64-linux-ld:
> drivers/built-in.o: .opd is not a regular array of opd entries
>   MODPOST vmlinux.o
>   GEN     .version
>   CHK     include/generated/compile.h
>   UPD     include/generated/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
> /opt/gcc-4.9.0-nolibc/powerpc64-linux/bin/powerpc64-linux-ld:
> drivers/built-in.o: .opd is not a regular array of opd entries
> drivers/built-in.o: In function `.ipw2100_up':
> ipw2100.c:(.text+0x1ff9c90): relocation truncated to fit:

"relocation truncated to fit"  errors are typical for ppc:allyesconfig.
allmodconfig should work, though.

Guenter
