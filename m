Return-Path: <bhe@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Wd2k55ZbzDqDX
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2018 01:18:54 +1000 (AEST)
Date: Thu, 19 Jul 2018 23:18:46 +0800
From: Baoquan He <bhe@redhat.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Nicolas Pitre <nicolas.pitre@linaro.org>,
 Josh Triplett <josh@joshtriplett.org>,
 kbuild test robot <fengguang.wu@intel.com>, Borislav Petkov <bp@suse.de>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 David Airlie <airlied@linux.ie>, KY Srinivasan <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Frank Rowand <frowand.list@gmail.com>, Keith Busch <keith.busch@intel.com>,
 Jon Derrick <jonathan.derrick@intel.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, brijesh.singh@amd.com,
 =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 baiyaowei@cmss.chinamobile.com, richard.weiyang@gmail.com,
 devel@linuxdriverproject.org, linux-input <linux-input@vger.kernel.org>,
 linux-nvdimm@lists.01.org, devicetree <devicetree@vger.kernel.org>,
 linux-pci@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 Yinghai Lu <yinghai@kernel.org>, Michal Simek <monstr@monstr.eu>,
 "David S. Miller" <davem@davemloft.net>,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 Gustavo Padovan <gustavo@padovan.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Sean Paul <seanpaul@chromium.org>, linux-parisc@vger.kernel.org,
 "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT"
 <linuxppc-dev@lists.ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v7 1/4] resource: Move reparent_resources() to
 kernel/resource.c and make it public
Message-ID: <20180719151846.GC7147@localhost.localdomain>
References: <20180718024944.577-1-bhe@redhat.com>
 <20180718024944.577-2-bhe@redhat.com>
 <CAHp75VdO88ydJQ9GHdaDUmAmzL6QHR=US6JiXZ1R_EEA-xWR1Q@mail.gmail.com>
 <CAHp75Vf2yEwHhEhhQH2XN+pOQ=-skiAHZ=FgLnfVV8vcm59qeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHp75Vf2yEwHhEhhQH2XN+pOQ=-skiAHZ=FgLnfVV8vcm59qeQ@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/18/18 at 07:37pm, Andy Shevchenko wrote:
> On Wed, Jul 18, 2018 at 7:36 PM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Wed, Jul 18, 2018 at 5:49 AM, Baoquan He <bhe@redhat.com> wrote:
> >> reparent_resources() is duplicated in arch/microblaze/pci/pci-common.c
> >> and arch/powerpc/kernel/pci-common.c, so move it to kernel/resource.c
> >> so that it's shared.
> 
> >> + * Returns 0 on success, -ENOTSUPP if child resource is not completely
> >> + * contained by 'res', -ECANCELED if no any conflicting entry found.
> 
> You also can refer to constants by prefixing them with %, e.g. %-ENOTSUPP.
> But this is up to you completely.

Thanks, will fix when repost. 
