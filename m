Message-ID: <000901c2a20b$23472400$370da8c0@aman>
From: "Aman" <aman@mistralsoftware.com>
To: "linuxppc embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: NVRAM/RTC
Date: Thu, 12 Dec 2002 23:50:23 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All

I have customized board , which has PPC 440GP as its processor. In this
board there is no NVRAM/RTC as in the 440GP evalkit. In the Rom monitor,
configuration related to it NVRAM/RTC has been removed. Because of this
changes in the rom monitor code, the linux image is hanging after " Now
Booting the Kernel". If  NVRAM/RTC EBC bank1 is enabled in rom monitor, the
linux image is executing without any problem. Can anyone say , how to
disable the NVRAM/RTC option in the linux kernel.

Thanking you in advance
Regards
Aman

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
