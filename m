Message-ID: <3B4F30F4.307C26BD@vnet.ibm.com>
Date: Fri, 13 Jul 2001 12:33:40 -0500
From: Todd Inglett <tinglett@vnet.ibm.com>
MIME-Version: 1.0
To: tom_gall@vnet.ibm.com
Cc: leigh@solinno.co.uk, linuxppc-dev@lists.linuxppc.org
Subject: Re: Booting 43P-140
References: <38851.193.133.92.239.994925353.squirrel@lbbrown.homeip.net> <3B4DCAAD.72D18C80@vnet.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Gall wrote:
[...snip....]
>   Do you have the latest firmware update on your machine? (It's like TIG99
> something)

Firmware can be found at
http://www.rs6000.ibm.com/support/micro/download.html and you'll
probably want the DOS version so you can install it straight from a
floppy.  Read the instructions carefully, please! :)  The latest for the
140 appears to be TIG99292.

[...snip...]
>   If you do get to the prompt, then type
>
> 0>  setenv real-base c00000
> 0>  setenv load-base 200000
> 0>  boot floppy:,\zimage root=/dev/fd0 load_ramdisk=1 ramdisk_size=128000

Also try adding console=ttyS0 in case your video adapter is the
problem.  You'll need a null modem serial cable over to another machine
running minicom, kermit or such.

--
-todd

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
