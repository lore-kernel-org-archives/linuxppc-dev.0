Return-Path: <jean.nicollerat@microdev.ch>
Received: from srv.brk07.com (srv.brk07.com [213.221.157.88])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8E6A967A6D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Mar 2005 19:02:33 +1100 (EST)
Received: from [81.13.179.73] (helo=chsetage)
	by srv.brk07.com with smtp (Exim 4.44) id 1DBpit-0003Ua-ME
	for linuxppc-embedded@ozlabs.org; Thu, 17 Mar 2005 08:47:16 +0100
From: "Jean Nicollerat MD" <jean.nicollerat@microdev.ch>
To: <linuxppc-embedded@ozlabs.org>
Date: Thu, 17 Mar 2005 08:47:46 +0100
Message-ID: <HMECJAKDCPLOGPDHNAHECEKFCAAA.jean.nicollerat@microdev.ch>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RTC with TQM823L
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,
I need to have an interrup every 10ms in my application running in linux.
I have a PowerPC 823 on the board TQM823L LCD from denx.
I use the ocan driver.
I try to use the RTC modules but with the code :

	fd = open ("/dev/rtc", O_RDONLY);

	if (fd ==  -1) {
		perror("/dev/rtc");
	}
	/* Turn on update interrupts (one per second) */

	retval = ioctl(fd, RTC_UIE_ON, 0);
	if (retval == -1) {
		perror("ioctl");
		//exit(errno);
	}

I get an error message :
  ioctl : invalide argument # for then line :"retval = ioctl(fd, RTC_UIE_ON,
0);"

Can somebody help ? why it is not working or a better way to get function
called each 10ms

Thanks

Jean
