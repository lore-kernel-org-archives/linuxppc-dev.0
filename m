Return-Path: <aik@ozlabs.ru>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yrPDL0ZtczDrKp
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Dec 2017 12:24:31 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id j4so9537996pgp.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Dec 2017 17:24:31 -0800 (PST)
Subject: Re: [PATCH v5 0/3] Prepartion for SR-IOV PowerVM Enablement
To: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>, helgaas@kernel.org,
 bhelgaas@google.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Cc: seroyer@linux.vnet.ibm.com, jjalvare@linux.vnet.ibm.com,
 alex.williamson@redhat.com, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bodong@mellanox.com, eli@mellanox.com,
 saeedm@mellanox.com
References: <20171109140035.64975-1-bryantly@linux.vnet.ibm.com>
 <520bad85-e4a5-a8a8-c893-e53e7b46c65c@ozlabs.ru>
 <3a49b44e-833a-8440-aa3c-a4984ac47147@linux.vnet.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <466ac4c0-6503-a2eb-e352-d2bdfca10cb5@ozlabs.ru>
Date: Tue, 5 Dec 2017 12:24:21 +1100
MIME-Version: 1.0
In-Reply-To: <3a49b44e-833a-8440-aa3c-a4984ac47147@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/12/17 02:08, Bryant G. Ly wrote:
> 
> 
> On 12/2/17 7:45 PM, Alexey Kardashevskiy wrote:
>> On 10/11/17 01:00, Bryant G. Ly wrote:
>>> v1 - Initial patch
>>> v2 - Addressed Bjorn's comment on creating a highly platform
>>>      dependent global exported symbol.
>>> v3 - Based patch off linux-ppc/master
>>> v4 - Using the sriov-drivers_autoprobe mechanism per Bjorn's request
>>> v5 - Fixed comments and commit message
>>
>> What is this made against of? I'd like to give it a try but it does not
>> apply to Linus'es tree or powerpc/next. Thanks.
>>
> This was made against powerpc/next back when it was still under 4.14-rc6.
> It has been in review for awhile... 

Sure, sha1 or github tree would be enough though to try.


> 
> -Bryant
> 
>>> Bryant G. Ly (3):
>>>   powerpc/kernel: Separate SR-IOV Calls
>>>   pseries: Add PSeries SR-IOV Machine dependent calls
>>>   PCI/IOV: Add pci_vf_drivers_autoprobe() interface
>>>
>>>  arch/powerpc/include/asm/machdep.h           |  7 ++++++
>>>  arch/powerpc/include/asm/pci-bridge.h        |  4 +---
>>>  arch/powerpc/kernel/eeh_driver.c             |  4 ++--
>>>  arch/powerpc/kernel/pci-common.c             | 23 +++++++++++++++++++
>>>  arch/powerpc/kernel/pci_dn.c                 |  6 -----
>>>  arch/powerpc/platforms/powernv/eeh-powernv.c | 33 ++++++++++++++--------------
>>>  arch/powerpc/platforms/powernv/pci-ioda.c    |  6 +++--
>>>  arch/powerpc/platforms/pseries/eeh_pseries.c | 24 ++++++++++++++++++++
>>>  arch/powerpc/platforms/pseries/pci.c         | 31 ++++++++++++++++++++++----
>>>  drivers/pci/iov.c                            | 11 ++++++++++
>>>  include/linux/pci.h                          |  2 ++
>>>  11 files changed, 118 insertions(+), 33 deletions(-)
>>>
>>
> 


-- 
Alexey
