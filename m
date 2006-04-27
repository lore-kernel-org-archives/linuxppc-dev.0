Return-Path: <jean-francois.hasson@hispano-suiza-sa.com>
Received: from snecma2.snecma.fr (snecma2.snecma.fr [195.220.252.67])
	by ozlabs.org (Postfix) with ESMTP id 654C4679E9
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Apr 2006 16:06:31 +1000 (EST)
From: <jean-francois.hasson@hispano-suiza-sa.com>
Received: from localhost (unknown [127.0.0.1])
	by H465140T.snecma.fr (Symantec Mail Security) with ESMTP id 30003A03
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Apr 2006 08:06:23 +0200 (CEST)
Received: from mail.snecma.fr (unknown [195.220.252.125])
	by H465140T.snecma.fr (Bienvenue au service SMTP) with ESMTP id
	11846A02 for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Apr 2006 08:06:23 +0200 (CEST)
Received: from h319300a.win-master.hsa.snecma ([128.30.41.23]) by
	mail.snecma.fr (AIX4.3/8.9.3/8.8.8) with ESMTP id HAA72316 for
	<linuxppc-embedded@ozlabs.org>; Thu, 27 Apr 2006 07:56:44 +0200
Subject: Linux 2.4 devel on ML403 board : problem with prompt
To: linuxppc-embedded@ozlabs.org
Message-ID: <OF86B9A972.248E5CE3-ONC125715D.0021112D-C125715D.002187E5@win-master.hsa.snecma>
Date: Thu, 27 Apr 2006 08:06:15 +0200
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

I am trying to port linux 2.4 devel to ML403. I have used advices from this
mailing list and some websites and finally got to th epoint where
everything seems find except I cannot get the boot prompt. I have used
busybox 1.0.1 and it seems init runs well, rcS runs well and afterr that I
do not get the prompt. I have activated the askfirst line in inittab and I
am asked to hit enter to go further but all I get is, automatically,
without hitting the keyboard, is character X. I do not seem to have any
echo. I have the console node defined in /dev. Has anyone an idea as to
what I have done wrong ?

Best regards,

JF Hasson



#
  This e-mail and any attached documents may contain confidential or proprietary information. If you are not the intended recipient, please advise the sender immediately and delete this e-mail and all attached documents from your computer system. Any unauthorised disclosure, distribution or copying hereof is prohibited. 

  Ce courriel et les documents qui y sont attaches peuvent contenir des informations confidentielles. Au cas ou vous ne seriez pas le destinataire de ce courriel, vous etes prie d'en informer l'expediteur immediatement et de le detruire  ainsi que tous les documents attaches de votre systeme informatique. Toute divulgation, distribution ou copie du present courriel et des documents attaches sans autorisation prealable de son emetteur est interdite. 
#
