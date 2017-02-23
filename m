Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0052.hostedemail.com
 [216.40.44.52])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vThgP6pVkzDqGh
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 04:53:53 +1100 (AEDT)
Message-ID: <1487872421.14159.38.camel@perches.com>
Subject: Re: [PATCH 00/35] treewide trivial patches converting pr_warning to
 pr_warn
From: Joe Perches <joe@perches.com>
To: Emil Velikov <emil.l.velikov@gmail.com>
Cc: Rob Herring <robh@kernel.org>, "linux-fbdev@vger.kernel.org"
 <linux-fbdev@vger.kernel.org>, linux-ia64@vger.kernel.org, SH-Linux
 <linux-sh@vger.kernel.org>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, ML nouveau
 <nouveau@lists.freedesktop.org>,  Linux-ALSA <alsa-devel@alsa-project.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER"
 <virtualization@lists.linux-foundation.org>, "linux-ide@vger.kernel.org"
 <linux-ide@vger.kernel.org>,  "linux-mtd@lists.infradead.org"
 <linux-mtd@lists.infradead.org>, sparclinux@vger.kernel.org,
 drbd-dev@lists.linbit.com, linux-scsi@vger.kernel.org, Richard Weinberger
 <richard@nod.at>, sfi-devel@simplefirmware.org, amd-gfx mailing list
 <amd-gfx@lists.freedesktop.org>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>, tboot-devel@lists.sourceforge.net,
 oprofile-list@lists.sf.net, "linux-input@vger.kernel.org"
 <linux-input@vger.kernel.org>, xen-devel@lists.xenproject.org,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org,  "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, gigaset307x-common@lists.sourceforge.net,
 acpi4asus-user@lists.sourceforge.net,
 adi-buildroot-devel@lists.sourceforge.net, Pekka Paalanen
 <ppaalanen@gmail.com>,  linux-omap <linux-omap@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, netdev <netdev@vger.kernel.org>,
 Karol Herbst <karolherbst@gmail.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,  linux-crypto@vger.kernel.org,
 linux-alpha@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 23 Feb 2017 09:53:41 -0800
In-Reply-To: <CACvgo50LUm5VSn_F=Dh8kL5zCPpCQDoCyUEL=Z+=1+6hJpfTaw@mail.gmail.com>
References: <cover.1487314666.git.joe@perches.com>
 <CAL_JsqLTaq-QLTqfyDO8EVJYpgeUx1e4J0Fo2NvfFWqVoiVedQ@mail.gmail.com>
 <1487870304.14159.29.camel@perches.com>
 <CACvgo50LUm5VSn_F=Dh8kL5zCPpCQDoCyUEL=Z+=1+6hJpfTaw@mail.gmail.com>
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

On Thu, 2017-02-23 at 17:41 +0000, Emil Velikov wrote:
> On 23 February 2017 at 17:18, Joe Perches <joe@perches.com> wrote:
> > On Thu, 2017-02-23 at 09:28 -0600, Rob Herring wrote:
> > > On Fri, Feb 17, 2017 at 1:11 AM, Joe Perches <joe@perches.com> wrote:
> > > > There are ~4300 uses of pr_warn and ~250 uses of the older
> > > > pr_warning in the kernel source tree.
> > > > 
> > > > Make the use of pr_warn consistent across all kernel files.
> > > > 
> > > > This excludes all files in tools/ as there is a separate
> > > > define pr_warning for that directory tree and pr_warn is
> > > > not used in tools/.
> > > > 
> > > > Done with 'sed s/\bpr_warning\b/pr_warn/' and some emacsing.
> > 
> > []
> > > Where's the removal of pr_warning so we don't have more sneak in?
> > 
> > After all of these actually get applied,
> > and maybe a cycle or two later, one would
> > get sent.
> > 
> 
> By which point you'll get a few reincarnation of it. So you'll have to
> do the same exercise again :-(

Maybe to one or two files.  Not a big deal.

> I guess the question is - are you expecting to get the series merged
> all together/via one tree ?

No.  The only person that could do that effectively is Linus.

> If not, your plan is perfectly reasonable.
