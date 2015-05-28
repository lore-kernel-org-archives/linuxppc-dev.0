Return-Path: <yhlu.kernel@gmail.com>
Received: from mail-wi0-x22e.google.com (mail-wi0-x22e.google.com
 [IPv6:2a00:1450:400c:c05::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B4E631A024B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 08:08:32 +1000 (AEST)
Received: by wicmx19 with SMTP id mx19so615473wic.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 15:08:29 -0700 (PDT)
MIME-Version: 1.0
Sender: yhlu.kernel@gmail.com
In-Reply-To: <4269355.CI4MW738Od@vostro.rjw.lan>
References: <20130725175242.6006.56007.stgit@bhelgaas-glaptop>
 <CAE9FiQXq59tSBM0SQ4OToXydZrRC3yukALmWEb6K9xpCGbdUhg@mail.gmail.com>
 <20150527193149.GD10210@google.com>
 <4269355.CI4MW738Od@vostro.rjw.lan>
Date: Thu, 28 May 2015 15:08:28 -0700
Message-ID: <CAE9FiQWDsQxKK3m4_-dSXm8V3xNc4oOtg2UQi=aayeKhLutwQg@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: pciehp: Convert pciehp to be builtin only,
 not modular
From: Yinghai Lu <yinghai@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 linux-sh@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mundt <lethal@linux-sh.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 27, 2015 at 6:30 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Wednesday, May 27, 2015 02:31:49 PM Bjorn Helgaas wrote:
> For debug you can always use pcie_ports=compat and that will disable
> pciehp too.

That will disable AER at the same time, right?.
