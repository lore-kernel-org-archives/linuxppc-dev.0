Return-Path: <andy.shevchenko@gmail.com>
Received: from mail-qt0-x229.google.com (mail-qt0-x229.google.com
 [IPv6:2607:f8b0:400d:c0d::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401fF30b4ZzF0nY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2018 04:42:30 +1100 (AEDT)
Received: by mail-qt0-x229.google.com with SMTP id z14so4354080qti.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 10:42:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHp75VdOaE-efzbQV=Mtf+a1-6L5JxF10Uc+uZ+LYz3S757biw@mail.gmail.com>
References: <20180314163455.15854-1-desnesn@linux.vnet.ibm.com>
 <20180314163455.15854-2-desnesn@linux.vnet.ibm.com>
 <CAHp75VdOaE-efzbQV=Mtf+a1-6L5JxF10Uc+uZ+LYz3S757biw@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 14 Mar 2018 19:42:28 +0200
Message-ID: <CAHp75VcbY9FhmngPOJ_d7ZxLUFmwPZhi7KdJSaPnqF1Db5UKEg@mail.gmail.com>
Subject: Re: [PATCH 1/2, pci] pci: Addition of PCI_DEV_FLAGS_QUIET_PCI_REALIGN
 attribute to the PCI subsystem
To: "Desnes A. Nunes do Rosario" <desnesn@linux.vnet.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-pci@vger.kernel.org,
 "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT"
 <linuxppc-dev@lists.ozlabs.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, ruscur@russell.cc, aik@ozlabs.ru,
 david@gibson.dropbear.id.au, fbarrat@linux.vnet.ibm.com,
 brking@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 14, 2018 at 7:41 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:

> I would rather name it _NO_PCI_REALIGN_MSG

I meant _NO_REALIGN_MSG of course (PCI is already at the beginning).

-- 
With Best Regards,
Andy Shevchenko
