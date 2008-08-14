Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 2AB4EDDF80
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Aug 2008 13:50:29 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1KTTqy-00036A-SQ
	for linuxppc-embedded@ozlabs.org; Wed, 13 Aug 2008 20:50:24 -0700
Message-ID: <18975316.post@talk.nabble.com>
Date: Wed, 13 Aug 2008 20:50:24 -0700 (PDT)
From: wangyanlong <killyouatonce@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: How to use ramdisk on the ml300?
In-Reply-To: <931ae8260808132008i1cac2e91kc76c099ecc574cd0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <931ae8260808132008i1cac2e91kc76c099ecc574cd0@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



 I use the make zImage.initrd to build my linux and i creat a
ramdisk file ,set the console root=/dev/ram.
  next i download the zImage.initrd.elf to the board,and down load
the ramdisk file to the right place , but  in the boot message , it
not try to load the ramdisk as rootfiles , it really boring me ,why?
  Thanks for your help
-- 
View this message in context: http://www.nabble.com/How-to-use-ramdisk-on-the-ml300--tp18975066p18975316.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
