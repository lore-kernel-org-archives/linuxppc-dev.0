Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C63C9140088
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Apr 2014 06:56:20 +1000 (EST)
Message-ID: <1397163353.3671.194.camel@pasglop>
Subject: Re: [PATCH] Fix 3bc95598 'powerpc/PCI: Use list_for_each_entry()
 for bus traversal'
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 11 Apr 2014 06:55:53 +1000
In-Reply-To: <CAErSpo6U7W+Nph3kCOBXcBTN7SeR9pVc5cfdQKTBDedWNnV8jg@mail.gmail.com>
References: <1397112695-3945-1-git-send-email-qiudayu@linux.vnet.ibm.com>
 <CAErSpo6U7W+Nph3kCOBXcBTN7SeR9pVc5cfdQKTBDedWNnV8jg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Yijing Wang <wangyijing@huawei.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Mike Qiu <qiudayu@linux.vnet.ibm.com>, anton@samba.org,
 "paulus@samba.org" <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-04-10 at 09:27 -0600, Bjorn Helgaas wrote:
> Ben, I'll pick this up for v3.15 since the original change
> (3bc955987fb3) went through my tree, unless you want to handle it.

Nah, go for it, I'm about to go on vacation for a week :-)

Thanks !

Cheers,
Ben.
