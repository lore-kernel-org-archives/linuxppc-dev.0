Return-Path: <hollisb@us.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E748F679A6
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2006 03:34:52 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k7SHYnBQ000750
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Aug 2006 13:34:49 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7SHYnPH243642
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Aug 2006 13:34:49 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7SHYm5M001266
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Aug 2006 13:34:48 -0400
Subject: copy_4K_page() doesn't use dcbtst?
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Mon, 28 Aug 2006 12:35:23 -0500
Message-Id: <1156786523.28490.52.camel@basalt.austin.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	xen-ppc-devel <xen-ppc-devel@lists.xensource.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul, some Xen people were just noticing that copy_4K_page
(arch/powerpc/lib/copypage_64.S) doesn't use the dcbtst instruction. Why
doesn't it help there?

-- 
Hollis Blanchard
IBM Linux Technology Center
