Message-ID: <002901bfed05$5b73d340$29e58aa4@crusman>
From: "Crusman" <Crusman@wanadoo.fr>
To: <paubert@iram.es>
Cc: "ppc_mailing" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: -= MVME 2300 =-
Date: Thu, 13 Jul 2000 22:03:00 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>The configurations I have are for 2600 with a PMC graphics board, remove
>CONFIG_VT from the setup and it will use a serial console.
>
>BTW use PrePboot for these boards (CONFIG_PREPBOOT) since it gives a nicer
>PCI layout to access the VMEbus...
>
>Please use the patches mvme2600.*.bz2...

I have tested the patches but the new kernel don't see the scsi device...so
I can't try it anyway !


>My systems work with an SCSI disk (the basic 2600 NCR53c825).
>Did you try to directly boot one of the images I have on my ftp site ?
>
>(If it works, you've got a configuration problem.)
>
> Gabriel

Yes, I have tested your kernel, but there is a message ( PC keyb error... or
something like this) wich lock the kernel during the boot ! It's probably
due to the Virtual Terminal support in the kernel !
I always use the "console=ttyS0,9600" kernel option.

In short :

- I can't use your kernel because of the PC_key error !
- I can't patch & build a new kernel because this new kernel don't see my
SCSI PMC !

What can I do ?

Lionel

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
