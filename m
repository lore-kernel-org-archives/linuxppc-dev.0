Return-Path: <ka99@mail.ru>
Received: from mx4.mail.ru (fallback.mail.ru [194.67.57.14])
	by ozlabs.org (Postfix) with ESMTP id A147267A67
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Apr 2005 18:56:12 +1000 (EST)
Received: from f6.mail.ru (f6.mail.ru [194.67.57.36])
	by mx4.mail.ru (mPOP.Fallback_MX) with ESMTP id 39E2F168D41
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Apr 2005 12:17:07 +0400 (MSD)
Received: from mail by f6.mail.ru with local id 1DOtLO-000OW6-00
	for linuxppc-embedded@ozlabs.org; Fri, 22 Apr 2005 12:16:58 +0400
From: =?koi8-r?Q?=D0=C5=D4=D2=20=D0=C5=D4=D2=CF=D7?= <ka99@mail.ru>
To: linuxppc-embedded@ozlabs.org
Mime-Version: 1.0
Date: Fri, 22 Apr 2005 12:16:58 +0400
Content-Type: text/plain; charset=koi8-r
Message-Id: <E1DOtLO-000OW6-00.ka99-mail-ru@f6.mail.ru>
Subject: problem with INI-9100U driver for INIC-940P SCSI controller
Reply-To: =?koi8-r?Q?=D0=C5=D4=D2=20=D0=C5=D4=D2=CF=D7?= <ka99@mail.ru>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


                                   Hello all!
 
       My name is Alex. I am porting linux to shr4162 target. This is PPC based target. It has Inic940P SCSI
     
       controller. When attaching a SCSI disk I can monitor from time to time the folloing problem:

       even first request for disk info( vendor Id, Model, etc) fails because no interrupts are caught by cpu
   
       or scsi controller does not issue interrupts after completetion of the request. As I said this situation 

       is floating - during some Linux bootings, this request and some other basic requests( capacity request,
     
       reading partition table and ctr.) work fine. The disk itself is Ok. It works fine on analogous target, based

       on ARM920CPU and having same SCSI contrller( Inic-940P). If anybody experienced similar problems, please

       share your experience. I would appriciate much.

       Kind regards,
       Kirnasov A.
