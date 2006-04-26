Return-Path: <g.jaeger@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [62.8.134.5])
	by ozlabs.org (Postfix) with ESMTP id 52AE2679E6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Apr 2006 17:51:04 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.sysgo.com (Postfix) with ESMTP id EF0C4FB85F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Apr 2006 09:26:26 +0200 (CEST)
Received: from donald.sysgo.com (unknown [172.20.1.30])
	by mail.sysgo.com (Postfix) with ESMTP id E040FFB85F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Apr 2006 09:26:26 +0200 (CEST)
Received: from kah.ulm.sysgo.com (kah.sysgo.com [172.40.1.2])
	by donald.sysgo.com (Postfix) with ESMTP id 4D6F0D0015D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Apr 2006 09:26:22 +0200 (CEST)
Received: from gja.ulm.sysgo.com (gja.ulm.sysgo.com [172.40.1.130])
	by kah.ulm.sysgo.com (8.9.3/8.8.8) with ESMTP id JAA14111
	for <linuxppc-embedded@ozlabs.org>; Wed, 26 Apr 2006 09:32:30 +0200
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: PPC Linux support for Tundra TSI148
Date: Wed, 26 Apr 2006 09:26:13 +0200
References: <821B2170E9E7F04FA38DF7EC21DE487104970DA7@VCAEXCH01.hq.corp.viasat.com>
In-Reply-To: <821B2170E9E7F04FA38DF7EC21DE487104970DA7@VCAEXCH01.hq.corp.viasat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200604260926.14221.g.jaeger@sysgo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wednesday 26 April 2006 01:47, Martin, Tim wrote:
> Does anyone out there have any real world measured performance of a
> Linux PowerPC (kernel module + user space application) doing 2eSST VME
> transfers with the Tundra TSI148 chipset?
> 
> Tundra has a Linux driver available for the Motorola MVME6100 , but told
> me they don't have any performance data available.  I'm looking for
> sustained throughput rates, not the peak burst rates (e.g. 320 MBps, 267
> MBps).
> 

Hi,

I've done here some tests between two MVME6100, while updating the 6100 BSP
for our embedded Linux distro. Depending on the buffersize, alignment, VME and 
PCI FIFO settings we have (without further optimizations) throughput rates ranging
from 100MBps up to 168MBps. I think some tuning could still be done.

HTH
Gerhard

-- 
Gerhard Jaeger <gjaeger@sysgo.com>            
SYSGO AG                      Embedded and Real-Time Software
www.sysgo.com | www.elinos.com | www.pikeos.com | www.osek.de 
