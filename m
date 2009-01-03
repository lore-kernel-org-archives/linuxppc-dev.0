Return-Path: <xyzzy@speakeasy.org>
Received: from mail4.sea5.speakeasy.net (mail4.sea5.speakeasy.net
	[69.17.117.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.speakeasy.net", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A7433DE02B
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Jan 2009 11:24:57 +1100 (EST)
Received: from shell2.sea5.speakeasy.net ([69.17.116.3])
	(envelope-sender <xyzzy@speakeasy.org>)
	by mail4.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted
	SMTP for <linuxppc-dev@ozlabs.org>; 3 Jan 2009 00:18:11 -0000
Date: Fri, 2 Jan 2009 16:18:11 -0800 (PST)
From: Trent Piepho <xyzzy@speakeasy.org>
To: linuxppc-dev@ozlabs.org
Subject: Status of fsl booke TLB and ATMU patches
Message-ID: <Pine.LNX.4.58.0901021611260.25853@shell2.speakeasy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Gala Kumar <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

2.6.28 is out, can my existing patches be accepted?

[2/2] POWERPC/fsl-pci: Set relaxed ordering on prefetchable ranges
http://patchwork.ozlabs.org/patch/14546/

[1/2] POWERPC/fsl-pci: Better ATMU setup
http://patchwork.ozlabs.org/patch/14544/

[5/5] powerpc: booke: Allow larger CAM sizes than 256 MB
http://patchwork.ozlabs.org/patch/12885/

[4/5] powerpc: booke: Make CAM entries used for lowmem configurable
http://patchwork.ozlabs.org/patch/12884/

[3/5] powerpc: booke: Remove code duplication in lowmem mapping
http://patchwork.ozlabs.org/patch/12883/

[2/5] powerpc: booke: Remove num_tlbcam_entries
http://patchwork.ozlabs.org/patch/12882/

[1/5] powerpc: booke: Don't hard-code size of struct tlbcam
http://patchwork.ozlabs.org/patch/12881/
