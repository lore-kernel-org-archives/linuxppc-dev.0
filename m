Message-Id: <3.0.6.32.19990302104633.00800150@hsins.uia.ac.be>
Date: Tue, 02 Mar 1999 10:46:33 +0100
To: "Mike McQuade" <mmcquade@aa.net>
From: David De Ridder <david.de.ridder@bitsmart.com>
Subject: Re: Kernel boot arguments over network
Cc: <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <000801be6425$b23751d0$0100a8c0@mikem>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Mike McQuade, with bold words breaking the horrid silence thus began :

>The params you pass in are at the Linux boot prompt,
>you see this prompt at the serial term right after
>you start the boot process.

 But therefore, the kernel needs a serial console at boot -
 which it doesn't have. With CONF_SERIAL_ECHO, it is possible
 to echo all kernel messages (e.g. the ones you see when linux
 boots) to a serial port, but it's one-way traffic. You cannot
 type anything before the file system is mounted (because you
 need getty or the like to create a serial console).

 The MVME230x series boards have NO harddisk, so using LILO or
 LoadLin doesn't seem possible.

>I rmember having to modify one of the C files in the kernel
>to make the boot device == NFS, without this mod,
>the kernel would panic.

 Doesn't the option 'root=/dev/nfs' do the same ?

>do you get anything out the serial port on startup ?

 Yes, the kernel I have (from Gabriel Paubert) gets as far as
 'Now booting...', and then hangs. Does anyone know what phase should 
 be next ?

 Regards,

+-----------------------------------------------------------------+
  David 'Septimus' De Ridder       <david.de.ridder@bitsmart.com> 

"Philosophy is not a supermarket."

+-----------------------------------------------------------------+
  


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
