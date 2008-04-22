Return-Path: <michel@tungstengraphics.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.184])
	by ozlabs.org (Postfix) with ESMTP id E2A0CDE6E8
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 02:04:35 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id g16so1124990nfd.9
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 09:04:33 -0700 (PDT)
Subject: Re: [PATCH 1/3] radeonfb: Fix 64 bits resources on 32 bits archs
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
To: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
In-Reply-To: <480E0A54.9010203@linux.vnet.ibm.com>
References: <20080422012723.BA9F2DE13F@ozlabs.org>
	<480E0A54.9010203@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Apr 2008 18:04:29 +0200
Message-Id: <1208880269.5632.262.camel@thor.sulgenrain.local>
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

On Tue, 2008-04-22 at 17:55 +0200, Christian Ehrhardt wrote:
> 
> You see it e.g. when you try to initialize X11, the x11 radeon driver
> issues a FBIOGET_FSCREENINFO ioctl [...]

FWIW, current versions of the xf86-video-ati radeon driver no longer use
radeonfb for anything.


-- 
Earthling Michel Dänzer           |          http://tungstengraphics.com
Libre software enthusiast         |          Debian, X and DRI developer
