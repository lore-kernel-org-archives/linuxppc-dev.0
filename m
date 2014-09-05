Return-Path: <bhelgaas@google.com>
Received: from mail-qa0-x22c.google.com (mail-qa0-x22c.google.com
 [IPv6:2607:f8b0:400d:c00::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 079971A00A5
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Sep 2014 07:28:12 +1000 (EST)
Received: by mail-qa0-f44.google.com with SMTP id j7so11496686qaq.17
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Sep 2014 14:28:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140905212528.GG8080@google.com>
References: <cover.1405160163.git.agordeev@redhat.com>
 <20140905212528.GG8080@google.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 5 Sep 2014 15:27:49 -0600
Message-ID: <CAErSpo4XN01hgTUpcca=i-=LFV_bM-Cok8614LJzrOfVbx8MAA@mail.gmail.com>
Subject: Re: [PATCH 0/2] PCI/MSI: Remove arch_msi_check_device()
To: Alexander Gordeev <agordeev@redhat.com>
Content-Type: text/plain; charset=UTF-8
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 5, 2014 at 3:25 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Sat, Jul 12, 2014 at 01:21:06PM +0200, Alexander Gordeev wrote:
>> Hello,
>>
>> This is a cleanup effort to get rid of useless arch_msi_check_device().
>> I am not sure what were the reasons for its existence in the first place,
>> but at the moment it appears totally unnecessary.
>>
>> Thanks!
>>
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Cc: linux-pci@vger.kernel.org
>>
>> Alexander Gordeev (2):
>>   PCI/MSI/PPC: Remove arch_msi_check_device()
>>   PCI/MSI: Remove arch_msi_check_device()
>
> I applied these (with Michael's ack on the first, and v2 of the second) to
> pci/msi for v3.18, thanks!
>>
>>  arch/powerpc/include/asm/machdep.h     |    2 -
>>  arch/powerpc/kernel/msi.c              |   12 +-------
>>  arch/powerpc/platforms/cell/axon_msi.c |    9 ------
>>  arch/powerpc/platforms/powernv/pci.c   |   19 +++---------
>>  arch/powerpc/platforms/pseries/msi.c   |   42
>>  ++++++++++----------------- arch/powerpc/sysdev/fsl_msi.c          |
>>  12 ++------ arch/powerpc/sysdev/mpic_pasemi_msi.c  |   11 +------
>>  arch/powerpc/sysdev/mpic_u3msi.c       |   28 +++++++-----------
>>  arch/powerpc/sysdev/ppc4xx_hsta_msi.c  |   18 ++++--------
>>  arch/powerpc/sysdev/ppc4xx_msi.c       |   19 ++++--------
>>  drivers/pci/msi.c                      |   49
>>  ++++++++----------------------- include/linux/msi.h                    |
>>  3 -- 12 files changed, 63 insertions(+), 161 deletions(-)

Oh, I forgot -- if you'd rather take the first one through the PPC
tree, you can do that and I can merge the second one later.  Let me
know if you want to do that.

Bjorn
