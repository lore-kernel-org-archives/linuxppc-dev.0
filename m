Return-Path: <dimensions_infinite@yahoo.com>
Received: from web33213.mail.mud.yahoo.com (web33213.mail.mud.yahoo.com
	[209.191.69.161]) by ozlabs.org (Postfix) with SMTP id 9AAB467BC4
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 14 Aug 2006 21:42:07 +1000 (EST)
Message-ID: <20060814113526.71320.qmail@web33213.mail.mud.yahoo.com>
Date: Mon, 14 Aug 2006 04:35:26 -0700 (PDT)
From: pranav choudhary <dimensions_infinite@yahoo.com>
Subject: U-boot and 2.6 kernel
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-610614270-1155555326=:70988"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-610614270-1155555326=:70988
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,
I am using an old version of u-boot and 2.6.13 kernel on IXDP425 hardware. The booting process stalls. After a little debugging i found that the booting stalls sfter call to jump() [__FUNCTION__ = CON_Run_Firmware, __FILE__ == conleaf.c. It seems that the correct image is not copied to KERNEL_RUN_ADDRESS.
I found another thread that talked of old u-boot and 2.6 kernels but i could not make out anything useful from it. Can someone please give me some pointers on where to start debugging...

---
dimensions_infinite@yahoo.com


Pranav Choudhary
Software Engineer
Net Devices India Pvt. Ltd
Bangalore

 		
---------------------------------
How low will we go? Check out Yahoo! Messenger’s low  PC-to-Phone call rates.
--0-610614270-1155555326=:70988
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,<br>I am using an old version of u-boot and 2.6.13 kernel on IXDP425 hardware. The booting process stalls. After a little debugging i found that the booting stalls sfter call to jump() [__FUNCTION__ = CON_Run_Firmware, __FILE__ == conleaf.c. It seems that the correct image is not copied to KERNEL_RUN_ADDRESS.<br>I found another thread that talked of old u-boot and 2.6 kernels but i could not make out anything useful from it. Can someone please give me some pointers on where to start debugging...<br><br>---<br>dimensions_infinite@yahoo.com<br><BR><BR><span style="color: rgb(255, 0, 0);">Pranav Choudhary<br><span style="color: rgb(0, 96, 191);"><font size="2">Software Engineer</font></span><br><span style="color: rgb(0, 0, 191);"><font size="2">Net Devices India Pvt. Ltd<br>Bangalore<br></font></span></span><p>&#32;
		<hr size=1>How low will we go? Check out Yahoo! Messenger’s low <a href="http://us.rd.yahoo.com/mail_us/taglines/postman8/*http://us.rd.yahoo.com/evt=39663/*http://voice.yahoo.com"> PC-to-Phone call rates.
--0-610614270-1155555326=:70988--
