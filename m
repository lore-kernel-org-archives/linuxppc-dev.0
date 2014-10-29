Return-Path: <jani.nikula@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by lists.ozlabs.org (Postfix) with ESMTP id E92D71A0063
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Oct 2014 18:55:02 +1100 (AEDT)
From: Jani Nikula <jani.nikula@intel.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] drivers: depend on instead of select
 BACKLIGHT_CLASS_DEVICE and ACPI_VIDEO
In-Reply-To: <1414551853.7417.1.camel@concordia>
References: <1413580403-16225-1-git-send-email-jani.nikula@intel.com>
 <54476492.6090105@ti.com> <87a94hu3j0.fsf@intel.com>
 <544E44E9.4040208@ti.com> <544FFC91.9040104@infradead.org>
 <1414551853.7417.1.camel@concordia>
Date: Wed, 29 Oct 2014 09:54:36 +0200
Message-ID: <87tx2njooz.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-fbdev@vger.kernel.org, linux-usb@vger.kernel.org,
 Daniel Drake <dsd@laptop.org>, Jens Frederich <jfrederich@gmail.com>,
 David Airlie <airlied@linux.ie>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jon Nettleton <jon.nettleton@gmail.com>, Jingoo Han <jg1.han@samsung.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 platform-driver-x86@vger.kernel.org, Bryan Wu <cooloney@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Daniel Vetter <daniel.vetter@intel.com>, Darren Hart <dvhart@infradead.org>,
 Lee Jones <lee.jones@linaro.org>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 29 Oct 2014, Michael Ellerman <mpe@ellerman.id.au> wrote:
> On Tue, 2014-10-28 at 13:29 -0700, Randy Dunlap wrote:
>> On 10/27/14 06:13, Tomi Valkeinen wrote:
>> > I also think the 'depends on BACKLIGHT_CLASS_DEVICE ||
>> > BACKLIGHT_CLASS_DEVICE=n' pattern is quite... interesting (i.e. sounds
>> > like a hack to me =).
>> 
>> It does exactly what is needed and it is used in many places in kernel
>> Kconfig files.
>
> Is there any reason you can't do:
>
>   depends on BACKLIGHT_CLASS_DEVICE != m

That's not the same thing. The FOO || FOO=n allows for all options, but
forbids it being a module when the option depending on it is
built-in. Obviously something that's built-in can't depend on something
built as a module.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Technology Center
