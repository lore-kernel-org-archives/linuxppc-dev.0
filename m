Return-Path: <jean-francois.hasson@hispano-suiza-sa.com>
Received: from snecma2.snecma.fr (snecma2.snecma.fr [195.220.252.67])
	by ozlabs.org (Postfix) with ESMTP id 6444167A5A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Apr 2006 17:27:55 +1000 (EST)
From: <jean-francois.hasson@hispano-suiza-sa.com>
Received: from localhost (unknown [127.0.0.1])
	by H465140T.snecma.fr (Symantec Mail Security) with ESMTP id 48287A3F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Apr 2006 09:27:41 +0200 (CEST)
Received: from mail.snecma.fr (unknown [195.220.252.125])
	by H465140T.snecma.fr (Bienvenue au service SMTP) with ESMTP id
	2A901A46 for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Apr 2006 09:27:41 +0200 (CEST)
Received: from h319300a.win-master.hsa.snecma ([128.30.41.23]) by
	mail.snecma.fr (AIX4.3/8.9.3/8.8.8) with ESMTP id JAA31870 for
	<linuxppc-embedded@ozlabs.org>; Tue, 11 Apr 2006 09:17:57 +0200
Subject: init issue on linux 2.4 devel and busybox
To: linuxppc-embedded@ozlabs.org
Message-ID: <OFE3D2A611.E87D47CE-ONC125714D.0028476E-C125714D.0028C0EB@win-master.hsa.snecma>
Date: Tue, 11 Apr 2006 09:25:05 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
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

I have been working on porting linux 2.4 devel to the ml403 board. It boots
well and then it goes on the CompactFlash to get the root filesystem where
the executables are from busybox. The init program is found and launches
well however the message is that init.d/rcS can't be found. I have looked
up my inittab file and the first line is ::sysinit:/etc/init.d/rcS. I do
not understand why init can't find the rcS file when it seems correct in
inittab and I have checked that the file rcS is in /etc/init.d. Does anyone
have an idea as to what might be wrong ?

Thanks,

JF Hasson



#
  This e-mail and any attached documents may contain confidential or proprietary information. If you are not the intended recipient, please advise the sender immediately and delete this e-mail and all attached documents from your computer system. Any unauthorised disclosure, distribution or copying hereof is prohibited. 

  Ce courriel et les documents qui y sont attaches peuvent contenir des informations confidentielles. Au cas ou vous ne seriez pas le destinataire de ce courriel, vous etes prie d'en informer l'expediteur immediatement et de le detruire  ainsi que tous les documents attaches de votre systeme informatique. Toute divulgation, distribution ou copie du present courriel et des documents attaches sans autorisation prealable de son emetteur est interdite. 
#
