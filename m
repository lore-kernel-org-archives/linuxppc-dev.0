Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 69EEAB70F0
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jul 2009 07:45:10 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B8FB2DDD0C
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Jul 2009 07:45:09 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Mark Nelson <markn@au1.ibm.com>
Subject: misaligned load/store in ppc32 memcpy
Message-Id: <6ABDC992-9D67-4C9C-A3A7-59F408FC9E50@kernel.crashing.org>
Content-Type: text/html; charset=US-ASCII
Mime-Version: 1.0 (Apple Message framework v935.3)
Date: Tue, 30 Jun 2009 16:56:31 -0500
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

<html><body class="ApplePlainTextBody" style="word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: after-white-space; ">Mark,<br><br>Ben pointed me to you regarding my question if we should be expecting misaligned load/store operations in the ppc32 mempcy that exists in copy_32.S.<br><br>(To be more specific, I'm seeing this behavior and wondering if we really should have memcpy avoid doing word size ld/st if the addresses aren't also aligned)<br><br>- k<br></body></html>
