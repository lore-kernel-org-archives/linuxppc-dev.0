To: "Sriram Narasimhan" <nsri@tataelxsi.co.in>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: initrd problems 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 24 Apr 2003 11:02:28 +0530."
             <3EA776EC.3090805@tataelxsi.co.in>
Date: Thu, 24 Apr 2003 09:35:08 +0200
Message-Id: <20030424073513.5846DC5E29@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3EA776EC.3090805@tataelxsi.co.in> you wrote:
>
> ## Booting image at 00100000 ...
>    Image Name:   Embedix for MPC8260ADS
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    531861 Bytes = 519.4 kB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
> ## Loading RAMDisk Image at 00200000 ...
>    Image Name:   Simple ramdisk Image
>    Image Type:   PowerPC Linux RAMDisk Image (uncompressed)
>    Data Size:    4194304 Bytes =  4 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Loading Ramdisk to 00b5e000, end 00f5e000 ... OK

Try using higher load addresses, i.e. load the kernel  at  0x00200000
and the ramdisk at 0x00400000.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A mouse is an elephant built by the Japanese.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
