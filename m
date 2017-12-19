Return-Path: <jani.nikula@intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1Rsl6gKvzF07k
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 05:54:51 +1100 (AEDT)
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Joe Perches <joe@perches.com>, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
 intel-gfx@lists.freedesktop.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, linux-nvme@lists.infradead.org,
 platform-driver-x86@vger.kernel.org, linux-s390@vger.kernel.org,
 esc.storagedev@microsemi.com, linux-scsi@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org,
 linux-sh@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [-next PATCH 0/4] sysfs and DEVICE_ATTR_<foo>
In-Reply-To: <cover.1513706701.git.joe@perches.com>
References: <cover.1513706701.git.joe@perches.com>
Date: Tue, 19 Dec 2017 20:54:32 +0200
Message-ID: <87vah2o8ev.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 19 Dec 2017, Joe Perches <joe@perches.com> wrote:
>  drivers/gpu/drm/i915/i915_sysfs.c                  | 12 ++--

For i915,

Acked-by: Jani Nikula <jani.nikula@intel.com>


-- 
Jani Nikula, Intel Open Source Technology Center
