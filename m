Return-Path: <Alexander.Povolotsky@marconi.com>
Received: from mailgate.pit.comms.marconi.com (mailgate.pit.comms.marconi.com
	[169.144.68.6]) by ozlabs.org (Postfix) with ESMTP id 86F482BF10
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 31 Dec 2004 09:28:05 +1100 (EST)
Received: from mailman.pit.comms.marconi.com (mailman.pit.comms.marconi.com
	[169.144.2.12])
	by mailgate.pit.comms.marconi.com (8.12.10+Sun/8.12.10) with ESMTP id
	iBUMRudt017460 for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Dec 2004 17:27:56 -0500 (EST)
Received: from uspitsmsgrtr01.pit.comms.marconi.com
	(uspitsmsgrtr01.pit.comms.marconi.com [169.144.2.221])
	by mailman.pit.comms.marconi.com (8.9.3/8.9.3) with ESMTP id RAA03825
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Dec 2004 17:27:55 -0500 (EST)
Message-ID: <313680C9A886D511A06000204840E1CF0A647439@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: linuxppc-embedded@ozlabs.org
Date: Thu, 30 Dec 2004 17:27:53 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: inflate returned FFFFFFFD - what does this error exactly mean ?
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

After few days of wondering through debugging (and with great help) I fixed
(by inserting watch dog resets into beginning of  while loops in zlib
functions) my first problem -strange reboot failures during decompression of
the kernel image by the bootloader.
However my luck expired beyond this fix so far ... ;-).
Now I am getting "controlled" failure (during the same decompression as
described above):

I_BAD
return Z_DATA_ERROR
after zlib_inflate
inflate returned FFFFFFFD
exit

what does this error exactly mean ?

Thanks,
Best Regards,
Alex 
