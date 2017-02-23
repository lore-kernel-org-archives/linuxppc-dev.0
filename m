Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0227.hostedemail.com
 [216.40.44.227])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTgtq0wMbzDqGV
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 04:18:42 +1100 (AEDT)
Message-ID: <1487870304.14159.29.camel@perches.com>
Subject: Re: [PATCH 00/35] treewide trivial patches converting pr_warning to
 pr_warn
From: Joe Perches <joe@perches.com>
To: Rob Herring <robh@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>, Karol Herbst
 <karolherbst@gmail.com>, Pekka Paalanen <ppaalanen@gmail.com>, Richard
 Weinberger <richard@nod.at>, Fabio Estevam <fabio.estevam@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, tboot-devel@lists.sourceforge.net,
 nouveau@lists.freedesktop.org, oprofile-list@lists.sf.net,
 sfi-devel@simplefirmware.org, xen-devel@lists.xenproject.org,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 drbd-dev@lists.linbit.com,  virtualization@lists.linux-foundation.org,
 linux-crypto@vger.kernel.org,  "linux-ide@vger.kernel.org"
 <linux-ide@vger.kernel.org>, gigaset307x-common@lists.sourceforge.net,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, linux-omap
 <linux-omap@vger.kernel.org>,  "linux-mtd@lists.infradead.org"
 <linux-mtd@lists.infradead.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, acpi4asus-user@lists.sourceforge.net,
 platform-driver-x86@vger.kernel.org, linux-scsi@vger.kernel.org,
 "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Linux-ALSA
 <alsa-devel@alsa-project.org>,  linux-alpha@vger.kernel.org,
 adi-buildroot-devel@lists.sourceforge.net,  linux-ia64@vger.kernel.org,
 SH-Linux <linux-sh@vger.kernel.org>,  sparclinux@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel <dri-devel@lists.freedesktop.org>,
 "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, netdev
 <netdev@vger.kernel.org>
Date: Thu, 23 Feb 2017 09:18:24 -0800
In-Reply-To: <CAL_JsqLTaq-QLTqfyDO8EVJYpgeUx1e4J0Fo2NvfFWqVoiVedQ@mail.gmail.com>
References: <cover.1487314666.git.joe@perches.com>
 <CAL_JsqLTaq-QLTqfyDO8EVJYpgeUx1e4J0Fo2NvfFWqVoiVedQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-02-23 at 09:28 -0600, Rob Herring wrote:
> On Fri, Feb 17, 2017 at 1:11 AM, Joe Perches <joe@perches.com> wrote:
> > There are ~4300 uses of pr_warn and ~250 uses of the older
> > pr_warning in the kernel source tree.
> > 
> > Make the use of pr_warn consistent across all kernel files.
> > 
> > This excludes all files in tools/ as there is a separate
> > define pr_warning for that directory tree and pr_warn is
> > not used in tools/.
> > 
> > Done with 'sed s/\bpr_warning\b/pr_warn/' and some emacsing.
[]
> Where's the removal of pr_warning so we don't have more sneak in?

After all of these actually get applied,
and maybe a cycle or two later, one would
get sent.
