Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
 by lists.ozlabs.org (Postfix) with ESMTP id 68E4D1A0D02
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 17:48:42 +1100 (AEDT)
Message-ID: <54BF49B6.9020704@daenzer.net>
Date: Wed, 21 Jan 2015 15:39:50 +0900
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
MIME-Version: 1.0
To: luigi burdo <intermediadc@hotmail.com>
Subject: Re: PowerMac G5 Quad Issue reporting
References: <20150120054506.F13591402E0@ozlabs.org>,
 <54BE3B79.9070004@linux.vnet.ibm.com>
 <DUB117-W1231755B8D223132D571329C84B0@phx.gbl>
In-Reply-To: <DUB117-W1231755B8D223132D571329C84B0@phx.gbl>
Content-Type: text/plain; charset=utf-8
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 20.01.2015 20:52, luigi burdo wrote:
> Hello all LinuxPPc Developer,
> need to report a issue that im facing from kernel 3.16 and up.
> 
> The fans of powermac g5 quad start boosting like a turbo jet after the
> system is
> been loaded and up.
> Usually this become after about 30-60 seconds when the system is loaded.

You need to load the i2c_powermac kernel module.


> Need to report to Michel D. from amd.com . The RadeonHD 6570 now is
> working on PowerMac G5 too
> look like the Xorg bigendian  issue related Evergreen / Northern  is
> been fixed ;-)

Xorg itself has always been working, only OpenGL can be problematic.
Have you verified r600_dri.so is used for that?


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer
