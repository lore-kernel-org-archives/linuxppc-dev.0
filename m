Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 74B4B1A0063
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Oct 2014 14:04:26 +1100 (AEDT)
Message-ID: <1414551853.7417.1.camel@concordia>
Subject: Re: [PATCH] drivers: depend on instead of select
 BACKLIGHT_CLASS_DEVICE and ACPI_VIDEO
From: Michael Ellerman <mpe@ellerman.id.au>
To: Randy Dunlap <rdunlap@infradead.org>
Date: Wed, 29 Oct 2014 14:04:13 +1100
In-Reply-To: <544FFC91.9040104@infradead.org>
References: <1413580403-16225-1-git-send-email-jani.nikula@intel.com>
 <54476492.6090105@ti.com> <87a94hu3j0.fsf@intel.com>
 <544E44E9.4040208@ti.com> <544FFC91.9040104@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-fbdev@vger.kernel.org, linux-usb@vger.kernel.org,
 Daniel Drake <dsd@laptop.org>, Jens Frederich <jfrederich@gmail.com>,
 Jani Nikula <jani.nikula@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jon Nettleton <jon.nettleton@gmail.com>, Jingoo Han <jg1.han@samsung.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 platform-driver-x86@vger.kernel.org, Bryan Wu <cooloney@gmail.com>,
 David Airlie <airlied@linux.ie>, Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Daniel Vetter <daniel.vetter@intel.com>, Darren Hart <dvhart@infradead.org>,
 Lee Jones <lee.jones@linaro.org>, linuxppc-dev@lists.ozlabs.org,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-10-28 at 13:29 -0700, Randy Dunlap wrote:
> On 10/27/14 06:13, Tomi Valkeinen wrote:
> > I also think the 'depends on BACKLIGHT_CLASS_DEVICE ||
> > BACKLIGHT_CLASS_DEVICE=n' pattern is quite... interesting (i.e. sounds
> > like a hack to me =).
> 
> It does exactly what is needed and it is used in many places in kernel
> Kconfig files.

Is there any reason you can't do:

  depends on BACKLIGHT_CLASS_DEVICE != m

cheers
