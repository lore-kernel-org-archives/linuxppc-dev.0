Message-ID: <01C183C1.37F31990.svacca@valcom.com>
From: Steven Vacca <svacca@valcom.com>
Reply-To: "svacca@valcom.com" <svacca@valcom.com>
To: "LinuxEmbeddedMailList (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Proper syntax to open() device driver from app.
Date: Thu, 13 Dec 2001 10:30:42 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have a test driver, which turns an onboard LED ON or OFF,
resident and directly linked to the kernel image.

In chr_dev_init(), the driver's init func is called and the
device registers itself with a specified MAJOR number.
When my app runs, I'm not exactly sure of
what the proper syntax is to open() the driver (call the driver's
open() func in the file_operations struct) and then execute
ioctl() to send an LED ON or OFF cmd to the driver.

Does anyone have some examples of this?
Most info regards modules rather than resident drivers.

Am I correct in assuming that I should do something similar
to the following:

	hndl = open("/dev/led",O_WRONLY,0);
	ioctl(hndl,LED_ON,0);

Thanks,

ShutEye Thinkin

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
