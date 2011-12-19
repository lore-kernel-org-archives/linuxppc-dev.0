Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6FFA2B704C
 for <linuxppc-dev@ozlabs.org>; Tue, 20 Dec 2011 02:06:02 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: RapidIO Direct I/O Support?
Date: Mon, 19 Dec 2011 06:51:42 -0800
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E55202699B3D@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <CAJTBoNnMfegZid7bf_ZxunwVmk8QEpeTn8Bcfz7g3sneL76s9Q@mail.gmail.com>
References: <CAJTBoNnMfegZid7bf_ZxunwVmk8QEpeTn8Bcfz7g3sneL76s9Q@mail.gmail.com>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: Daniel Ng <daniel.ng1234@gmail.com>, <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday, December 19, 2011 1:39 AM, Daniel Ng wrote:

>Is there RapidIO Direct Memory I/O Support in the latest kernel?
>
>I've seen these patches from Freescale, but it seems they were never
integrated-
>http://kerneltrap.org/mailarchive/linux-netdev/2009/5/12/5686954
>
>Does anyone know why these weren't integrated?=20
>
>What is the latest state of these patches? Do they work?

I am in process of submitting set of patches that add DMA Engine support
into RapidIO subsystem. One of these patches brings back an upper level
interface for inbound memory mapping from referenced thread. It does not
include HW specific mapping for fsl_rio though.

I used an inbound mapping on 8548 based platform during my testing and
that part did not take too much time to get it working.

The v.2 set of my DMA patches will be published as soon as DMAengine
maintainers
release an update for dma_slave API.
For outbound SRIO requests new patches rely on DMA capabilities of SRIO
controller. These patches add DMA channel driver for Tsi721 PCIe-to-SRIO
bridge.

Alex.
