Return-Path: <bhelgaas@google.com>
Received: from mail-qc0-x22b.google.com (mail-qc0-x22b.google.com
 [IPv6:2607:f8b0:400d:c01::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 37CEA1A0431
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 00:52:40 +1100 (EST)
Received: by mail-qc0-f171.google.com with SMTP id i17so959213qcy.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Oct 2014 06:52:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20141015090014.GA13499@richard>
References: <1406182947-11302-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <20140819211942.GA6295@google.com> <20140820023404.GC6904@richard>
 <CAErSpo5Dm4Eu0TcvJn2fYLVd005OgJCy-yZAhqsttjbb8jwm=A@mail.gmail.com>
 <20140820033546.GA7669@richard> <20141002155943.GA19392@google.com>
 <20141015090014.GA13499@richard>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 15 Oct 2014 07:52:16 -0600
Message-ID: <CAErSpo4g1gtizAsVpxXGWRMDDaNLkjajqdj3xUdckiTf6f3g4Q@mail.gmail.com>
Subject: Re: [PATCH V7 00/17] Enable SRIOV on POWER8
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@au1.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 15, 2014 at 3:00 AM, Wei Yang <weiyang@linux.vnet.ibm.com> wrote:
> On Thu, Oct 02, 2014 at 09:59:43AM -0600, Bjorn Helgaas wrote:
...
>>I haven't seen any more on this series, and I'm assuming you'll post a
>>rebased series (maybe you're waiting for v3.18-rc1?).  I'm just checking to
>>make sure you're not waiting for something from me...
>>
>
> Hi, Bjorn
>
> Haven't seen you for a long time :-) I am just back from vocation and the mail
> box doesn't work well for previous two days.
>
> Yep, I am rebasing the code on top of v3.17, is this fine for you?

When I apply your patches, they will be on a branch based on
v3.18-rc1, so the easiest thing for me would be if you generate them
from that base.  Here's why:

  - Linus released v3.17 on Oct 5, 2014
  - Merge window for v3.18 opened when v3.17 released
  - All changes intended for v3.18 will be merged during window
(theoretically, at least)
  - Merge window closes when Linus releases v3.18-rc1 (probably Oct 19 or 26)

Your changes will miss the v3.18 merge window, so the next chance to
merge them will be during the v3.19 merge window that opens when v3.18
releases.  v3.18-rc1 is a close approximation of what v3.18 will
eventually be, so rebasing to v3.18-rc1 will minimize merge conflicts
when we eventually merge your changes on top of v3.18.

v3.18-rc1 isn't out yet, but if you rebase to the current head of
Linus' tree, that should be fairly close.  The PCI changes are already
in (80213c03c415), and at least some of the powerpc changes are in
(fd9879b9bb32).

Bjorn
