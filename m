Message-ID: <383010226.977253498093.JavaMail.root@web621-wrb.mail.com>
Date: Tue, 19 Dec 2000 14:18:18 -0500 (EST)
From: Matthew Locke <mlocke@onemain.com>
To: Dan Malek <dan@mvista.com>, Brett Carswell <BrettC@nulec.com.au>
Subject: Re: RPX Lite w MontaVista 1.2
CC: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Mime-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


no that works too.  The old bootloader (RPX-Utility) always setup the BR/OR
for NVRAM even if the board did not have NVRAM populated.  In the new
bootloader NVRAM is not mapped by default. if you enable NVRAM in its config
it will setup the BR/OR and then the kernel can access that area of memory.
Obviously, if you acutally try to do something with that area...

------Original Message------
From: Dan Malek <dan@mvista.com>
To: Brett Carswell <BrettC@nulec.com.au>
Sent: December 18, 2000 3:02:12 AM GMT
Subject: Re: RPX Lite w MontaVista 1.2



Brett Carswell wrote:
>
> I enabled the NVRAM in the config and everything works great now.

That's weird.  Something else is wrong.  The NVRAM config is irrelevant
on the  RPX-lite (and I think all 8xx boards).  The code I suggested you
remove is run long before the kernel, and the information you sent
earlier indicated the actual NVRAM was not mapped in the memory
controller.


-- Dan



_____________________________________
OneMain.com, Your Hometown Internet.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
