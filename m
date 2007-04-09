Return-Path: <andrew@cesa.opbu.xerox.com>
Received: from wbmler3.mail.xerox.com (wbmler3.mail.xerox.com [13.13.138.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wbmler3.mail.xerox.com",
	Issuer "wbmler3.mail.xerox.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 31DB2DDF10
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Apr 2007 04:54:04 +1000 (EST)
Received: from wbmlir1.mail.xerox.com (wbmlir1.mail.xerox.com [13.131.8.221])
	by wbmler3.mail.xerox.com (8.13.8/8.13.6) with ESMTP id
	l39ImV7J007501
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Apr 2007 14:48:31 -0400
Received: from wbmlir1.mail.xerox.com (localhost [127.0.0.1])
	by wbmlir1.mail.xerox.com (8.13.8/8.13.6) with ESMTP id l39ImMGP006082
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Apr 2007 14:48:22 -0400
Received: from hermes.opbu.xerox.com (hermes.opbu.xerox.com [13.62.6.81])
	by wbmlir1.mail.xerox.com (8.13.8/8.13.6) with ESMTP id l39ImLY4006030
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Apr 2007 14:48:22 -0400
Received: from pogo.cesa.opbu.xerox.com (pogo.cesa.opbu.xerox.com
	[13.62.33.31])
	by hermes.opbu.xerox.com (8.13.7+Sun/8.13.7) with ESMTP id
	l39ImKT3019841
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Apr 2007 11:48:20 -0700 (PDT)
Received: from cesa.opbu.xerox.com (gto.cesa.opbu.xerox.com [13.62.136.98])
	by pogo.cesa.opbu.xerox.com (8.13.6+Sun/8.13.6) with ESMTP id
	l39ImK6G003731
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Apr 2007 11:48:20 -0700 (PDT)
Message-Id: <200704091848.l39ImK6G003731@pogo.cesa.opbu.xerox.com>
To: linuxppc-dev@ozlabs.org
Subject: 85xx: howto request message interrupts?
Date: Mon, 09 Apr 2007 11:48:20 -0700
From: Andrew Klossner <andrew@cesa.opbu.xerox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In the Freescale linux-2.6-85xx tree, include/asm-powerpc/irq.h leads
me to think that there's no support for message interrupts in the
85xx.  Am I overlooking something, or do I need to add this myself?

Thanks,
Andrew Klossner
