Return-Path: <antonio.dibacco@aruba.it>
Received: from smtpa4.aruba.it (smtpa4.aruba.it [62.149.128.201])
	by ozlabs.org (Postfix) with SMTP id B773067B16
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Apr 2006 06:36:58 +1000 (EST)
From: Antonio Di Bacco <antonio.dibacco@aruba.it>
To: linuxppc-embedded@ozlabs.org
Subject: Upgrading cramfs root file system
Date: Thu, 6 Apr 2006 22:38:17 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200604062238.17972.antonio.dibacco@aruba.it>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

how could I upgrade my cramfs rootfs? I have a CGI in the rootfs that receives 
the new rootfs from a web interface and then tries to write it in the flash. 
While overwriting the old cramfs, the CGI will continue to work? something 
weird could happen?

Best regards,
Antonio.
