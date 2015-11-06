Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0A2FA1A0DE1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Nov 2015 12:11:25 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 6 Nov 2015 11:11:23 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 6DA97357804F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Nov 2015 12:11:19 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA61BArC57278648
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Nov 2015 12:11:19 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA61AjXu011012
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Nov 2015 12:10:46 +1100
Date: Fri, 6 Nov 2015 12:09:51 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Daniel Axtens <dja@axtens.net>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org, aik@ozlabs.ru, linux-pci@vger.kernel.org,
 panto@antoniou-consulting.com, grant.likely@linaro.org,
 robherring2@gmail.com, bhelgaas@google.com, frowand.list@gmail.com
Subject: Re: [PATCH v7 04/50] powerpc/powernv: Cleanup on
 pnv_pci_ioda_controller_ops
Message-ID: <20151106010951.GA4601@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-5-git-send-email-gwshan@linux.vnet.ibm.com>
 <87vb9ghyij.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87vb9ghyij.fsf@gamma.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 06, 2015 at 09:28:20AM +1100, Daniel Axtens wrote:
>Gavin Shan <gwshan@linux.vnet.ibm.com> writes:
>
>> This cleans up on pnv_pci_ioda_controller_ops struct to use tab
>> instead of space indent of statement to avoid complains from
>> scripts/checkpatch.pl. No logical changes introduced.
>
>Oh, that was my code :/ Sorry I missed that, thanks for cleaning it up!
>
>Reviewed-by: Daniel Axtens <dja@axtens.net>
>

nah, that's fine, Daniel. You might be saying: I didn't review your code
carefully enough, which leaves me the chance to clean it up :-)

Thanks,
Gavin

>>
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/platforms/powernv/pci-ioda.c | 18 +++++++++---------
>>  1 file changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>> index 2e2bedb..aa3645c 100644
>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>> @@ -3064,17 +3064,17 @@ static void pnv_pci_ioda_shutdown(struct pci_controller *hose)
>>  }
>>  
>>  static const struct pci_controller_ops pnv_pci_ioda_controller_ops = {
>> -       .dma_dev_setup = pnv_pci_dma_dev_setup,
>> +	.dma_dev_setup		= pnv_pci_dma_dev_setup,
>>  #ifdef CONFIG_PCI_MSI
>> -       .setup_msi_irqs = pnv_setup_msi_irqs,
>> -       .teardown_msi_irqs = pnv_teardown_msi_irqs,
>> +	.setup_msi_irqs		= pnv_setup_msi_irqs,
>> +	.teardown_msi_irqs	= pnv_teardown_msi_irqs,
>>  #endif
>> -       .enable_device_hook = pnv_pci_enable_device_hook,
>> -       .window_alignment = pnv_pci_window_alignment,
>> -       .reset_secondary_bus = pnv_pci_reset_secondary_bus,
>> -       .dma_set_mask = pnv_pci_ioda_dma_set_mask,
>> -       .dma_get_required_mask = pnv_pci_ioda_dma_get_required_mask,
>> -       .shutdown = pnv_pci_ioda_shutdown,
>> +	.enable_device_hook	= pnv_pci_enable_device_hook,
>> +	.window_alignment	= pnv_pci_window_alignment,
>> +	.reset_secondary_bus	= pnv_pci_reset_secondary_bus,
>> +	.dma_set_mask		= pnv_pci_ioda_dma_set_mask,
>> +	.dma_get_required_mask	= pnv_pci_ioda_dma_get_required_mask,
>> +	.shutdown		= pnv_pci_ioda_shutdown,
>>  };
>>  
>>  static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>> -- 
>> 2.1.0
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
