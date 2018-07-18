Return-Path: <andy.shevchenko@gmail.com>
Received: from mail-ua0-x243.google.com (mail-ua0-x243.google.com
 [IPv6:2607:f8b0:400c:c08::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41W2qq72S9zF3J3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2018 02:37:27 +1000 (AEST)
Received: by mail-ua0-x243.google.com with SMTP id y10-v6so3333217uao.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 09:37:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHp75VdO88ydJQ9GHdaDUmAmzL6QHR=US6JiXZ1R_EEA-xWR1Q@mail.gmail.com>
References: <20180718024944.577-1-bhe@redhat.com>
 <20180718024944.577-2-bhe@redhat.com>
 <CAHp75VdO88ydJQ9GHdaDUmAmzL6QHR=US6JiXZ1R_EEA-xWR1Q@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 18 Jul 2018 19:37:24 +0300
Message-ID: <CAHp75Vf2yEwHhEhhQH2XN+pOQ=-skiAHZ=FgLnfVV8vcm59qeQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] resource: Move reparent_resources() to
 kernel/resource.c and make it public
To: Baoquan He <bhe@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Nicolas Pitre <nicolas.pitre@linaro.org>, Josh Triplett <josh@joshtriplett.org>,
 kbuild test robot <fengguang.wu@intel.com>, Borislav Petkov <bp@suse.de>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 David Airlie <airlied@linux.ie>,
 KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Frank Rowand <frowand.list@gmail.com>, Keith Busch <keith.busch@intel.com>,
 Jon Derrick <jonathan.derrick@intel.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 brijesh.singh@amd.com,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 baiyaowei@cmss.chinamobile.com, richard.weiyang@gmail.com,
 devel@linuxdriverproject.org, linux-input <linux-input@vger.kernel.org>,
 linux-nvdimm@lists.01.org, devicetree <devicetree@vger.kernel.org>,
 linux-pci@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 Yinghai Lu <yinghai@kernel.org>,
 Michal Simek <monstr@monstr.eu>, "David S. Miller" <davem@davemloft.net>,
 Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>, Gustavo Padovan <gustavo@padovan.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Sean Paul <seanpaul@chromium.org>, linux-parisc@vger.kernel.org,
 "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT"
 <linuxppc-dev@lists.ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 18, 2018 at 7:36 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Jul 18, 2018 at 5:49 AM, Baoquan He <bhe@redhat.com> wrote:
>> reparent_resources() is duplicated in arch/microblaze/pci/pci-common.c
>> and arch/powerpc/kernel/pci-common.c, so move it to kernel/resource.c
>> so that it's shared.

>> + * Returns 0 on success, -ENOTSUPP if child resource is not completely
>> + * contained by 'res', -ECANCELED if no any conflicting entry found.

You also can refer to constants by prefixing them with %, e.g. %-ENOTSUPP.
But this is up to you completely.

-- 
With Best Regards,
Andy Shevchenko
