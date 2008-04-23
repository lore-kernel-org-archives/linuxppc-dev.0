Return-Path: <michel@tungstengraphics.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.154])
	by ozlabs.org (Postfix) with ESMTP id E582DDDFAC
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 19:32:25 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id 16so2200298fgg.39
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 02:32:23 -0700 (PDT)
Subject: Re: [Linux-fbdev-devel] [PATCH 1/3] radeonfb: Fix 64 bits
	resources on 32 bits archs
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
To: benh@kernel.crashing.org
In-Reply-To: <1208902903.9640.138.camel@pasglop>
References: <20080422012723.BA9F2DE13F@ozlabs.org>
	<480E0A54.9010203@linux.vnet.ibm.com>
	<1208902903.9640.138.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Apr 2008 11:32:07 +0200
Message-Id: <1208943127.5632.324.camel@thor.sulgenrain.local>
Mime-Version: 1.0
Cc: linux-fbdev-devel@lists.sourceforge.net,
	Hollis Blanchard <hollisb@us.ibm.com>, adaplas@gmail.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>, Detlev Zundel <dzu@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-04-23 at 08:21 +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2008-04-22 at 17:55 +0200, Christian Ehrhardt wrote:
> > I wanted to ask if there are any known workarounds atm that would
> > allow me to use my X11 for now?
> 
> X is doing a mmap of /dev/mem instead of /dev/fb ?
> 
> You can normally map the fb mapping /dev/fb and then map the registers
> using /dev/fb at an offset beyond the framebuffer (fix->smem_len).
> 
> If X is using /dev/mem instead, then it's being stupid and needs to be
> fixed...

It's up to the driver, and again, the current radeon driver doesn't use
radeonfb at all anymore...


-- 
Earthling Michel Dänzer           |          http://tungstengraphics.com
Libre software enthusiast         |          Debian, X and DRI developer
