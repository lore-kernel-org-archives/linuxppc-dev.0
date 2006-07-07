Return-Path: <glppd-linuxppc64-dev@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 689D9679FD
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Jul 2006 05:05:37 +1000 (EST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Fyv0j-0006Rg-HQ
	for linuxppc-dev@ozlabs.org; Fri, 07 Jul 2006 20:25:05 +0200
Received: from 24-159-197-73.dhcp.roch.mn.charter.com ([24.159.197.73])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Fri, 07 Jul 2006 20:25:05 +0200
Received: from drfickle by 24-159-197-73.dhcp.roch.mn.charter.com with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Fri, 07 Jul 2006 20:25:05 +0200
To: linuxppc-dev@ozlabs.org
From: Steve Fox <drfickle@us.ibm.com>
Subject: Re: Linux v2.6.18-rc1
Date: Fri, 07 Jul 2006 10:41:35 -0500
Message-ID: <pan.2006.07.07.15.41.35.528827@us.ibm.com>
References: <Pine.LNX.4.64.0607052115210.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: news <news@sea.gmane.org>
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We've got a ppc64 machine that won't boot with this due to an IDE error.

[snip]
Freeing unused kernel memory: 256k freed
 running (1:2) /init autobench_args: ABAT:1152213829

creating device nodes .hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt

-- 

Steve Fox
IBM Linux Technology Center
