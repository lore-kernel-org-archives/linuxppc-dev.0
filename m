Return-Path: <srs0=xg3m=2y=gmail.com=arndbergmann@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjr2Y6jXPzDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Mar 2017 23:07:33 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vjr2Y64yKz8t7d
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Mar 2017 23:07:33 +1100 (AEDT)
Received: from mail-ot0-x243.google.com (mail-ot0-x243.google.com
 [IPv6:2607:f8b0:4003:c0f::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vjr2X2hjTz9ryv
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Mar 2017 23:07:32 +1100 (AEDT)
Received: by mail-ot0-x243.google.com with SMTP id i1so2315747ota.3
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Mar 2017 05:07:32 -0700 (PDT)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <8760jbump6.fsf@concordia.ellerman.id.au>
References: <1473501690-11987-1-git-send-email-mpe@ellerman.id.au>
 <87wpbsuo4x.fsf@concordia.ellerman.id.au>
 <CAK8P3a0wfXrj3gJAffHLhqQjqcZWy2=WEVUordLxH-jOKAe0qw@mail.gmail.com>
 <8760jbump6.fsf@concordia.ellerman.id.au>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 15 Mar 2017 13:07:30 +0100
Message-ID: <CAK8P3a2TzAdOnyOyS5ZbQK5WRkNKnGxLc=7SYjw_Y75VdbnyZw@mail.gmail.com>
Subject: Re: [PATCH] drivers/pcmcia: NO_IRQ removal for electra_cf.c
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-pcmcia@lists.infradead.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, oss@buserror.net,
 linuxppc-dev@ozlabs.org,
 Claudiu Manoil <claudiu.manoil@nxp.com>, qiang.zhao@nxp.com
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 15, 2017 at 6:35 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
>> On Tue, Mar 14, 2017 at 11:51 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>>> Michael Ellerman <mpe@ellerman.id.au> writes:
>>>
>>
>> drivers/ata/pata_mpc52xx.c:     if (ata_irq == NO_IRQ) {
>> drivers/ata/sata_dwc_460ex.c:#ifndef NO_IRQ
>> drivers/ata/sata_dwc_460ex.c:#define NO_IRQ             0
>> drivers/ata/sata_dwc_460ex.c:   if (hsdev->dma->irq == NO_IRQ) {
>> drivers/ata/sata_dwc_460ex.c:   if (irq == NO_IRQ) {
>> drivers/iommu/fsl_pamu.c:       if (irq == NO_IRQ) {
>> drivers/iommu/fsl_pamu.c:       if (irq != NO_IRQ)
>> drivers/media/platform/fsl-viu.c:       if (viu_irq == NO_IRQ) {
>> drivers/mtd/nand/mpc5121_nfc.c: if (prv->irq == NO_IRQ) {
>> drivers/pcmcia/electra_cf.c:    cf->irq = NO_IRQ;
>> drivers/pcmcia/electra_cf.c:    if (cf->irq != NO_IRQ)
>> drivers/soc/fsl/qe/qe_ic.c:/* Return an interrupt vector or NO_IRQ if
>> no interrupt is pending. */
>> drivers/soc/fsl/qe/qe_ic.c:             return NO_IRQ;
>> drivers/soc/fsl/qe/qe_ic.c:/* Return an interrupt vector or NO_IRQ if
>> no interrupt is pending. */
>> drivers/soc/fsl/qe/qe_ic.c:             return NO_IRQ;
>> drivers/soc/fsl/qe/qe_ic.c:     if (qe_ic->virq_low == NO_IRQ) {
>> drivers/soc/fsl/qe/qe_ic.c:     if (qe_ic->virq_high != NO_IRQ &&
>> drivers/spi/spi-mpc52xx.c:      if (status && (irq != NO_IRQ))
>> drivers/tty/ehv_bytechan.c:     if (stdout_irq == NO_IRQ) {
>> drivers/tty/ehv_bytechan.c:     if ((bc->rx_irq == NO_IRQ) ||
>> (bc->tx_irq == NO_IRQ)) {
>> drivers/tty/serial/cpm_uart/cpm_uart_core.c:    if (pinfo->port.irq == NO_IRQ) {
>> drivers/uio/uio_fsl_elbc_gpcm.c:        if (irq != NO_IRQ) {
>> drivers/uio/uio_fsl_elbc_gpcm.c:                        irq = NO_IRQ;
>> drivers/uio/uio_fsl_elbc_gpcm.c:                 irq != NO_IRQ ? irq : -1);
>> drivers/usb/host/ehci-grlib.c:  if (irq == NO_IRQ) {
>> drivers/usb/host/ehci-ppc-of.c: if (irq == NO_IRQ) {
>> drivers/usb/host/fhci-hcd.c:    if (usb_irq == NO_IRQ) {
>> drivers/usb/host/ohci-ppc-of.c: if (irq == NO_IRQ) {
>> drivers/usb/host/uhci-grlib.c:  if (irq == NO_IRQ) {
>> drivers/video/fbdev/mb862xx/mb862xxfbdrv.c:     if (par->irq == NO_IRQ) {
>> drivers/virt/fsl_hypervisor.c:          if (!handle || (irq == NO_IRQ)) {
>> include/soc/fsl/qe/qe_ic.h:     if (cascade_irq != NO_IRQ)
>> include/soc/fsl/qe/qe_ic.h:     if (cascade_irq != NO_IRQ)
>> include/soc/fsl/qe/qe_ic.h:     if (cascade_irq != NO_IRQ)
>> include/soc/fsl/qe/qe_ic.h:     if (cascade_irq != NO_IRQ)
>> include/soc/fsl/qe/qe_ic.h:     if (cascade_irq == NO_IRQ)
>> include/soc/fsl/qe/qe_ic.h:     if (cascade_irq != NO_IRQ)
>>
>> Did you have other pending patches for those?
>
> No. I stayed away from anything FSL related as I was under the
> impression some of them were being ported to arch/arm, which uses -1 for
> NO_IRQ IIUIC.
>
> eg. all of include/soc/fsl and drivers/soc/fsl was moved from
> arch/powerpc in commit 7aa1aa6ecec2, which said:
>
>     QE: Move QE from arch/powerpc to drivers/soc
>
>     ls1 has qe and ls1 has arm cpu.
>     move qe from arch/powerpc to drivers/soc/fsl
>     to adapt to powerpc and arm
>
> But looking at the Kconfigs it looks like they're still only selectable
> on PPC. So that's a bit annoying.
>
> I'll do patches for everything above that's not drivers/soc or
> include/soc and hopefully we can hear from someone at NXP on the plans
> for getting the soc parts enabled on arm.

I think the removal of the NO_IRQ references is a requirement for
getting the drivers working properly on ARM, as the OF platform
code will use '0' for invalid IRQs.

    Arnd
