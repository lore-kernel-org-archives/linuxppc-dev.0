Message-ID: <3A1B12E9.46C3B9@mvista.com>
Date: Tue, 21 Nov 2000 16:27:21 -0800
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: "Ruhland, Paul" <pruhland@microwavedata.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [linuxppc-embedded] PCMCIA on MBX860
References: <DF2142DFD5ECD311BA1900104B943A979322A2@roche-exg1.rochester.adaptivebroadband.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


you need to change a config file.

in /etc/sysconfig/pcmcia

change the i82365 to m8xx_pcmica

"Ruhland, Paul" wrote:
>
> Matthew,
>
> I used 'pcmcia-cs-3.1.19.tar.gz', 'hhl-8xx_pcmcia-3.1.19.patch', and
> 'hhl-8xx-kernel_pcmcia.patch' from the mvista site.
>
> After adding MBX board specific code to 'modules/m8xx_pcmcia.c' the package
> succesfully compiles.  However, I now get the following errors when I try to
> load the module(s):
>
> ----------------------------------------
> sh-2.03# /etc/init.d/pcmcia start
> Starting PCMCIA services: modulesLinux PCMCIA Card Services 3.1.19
>   kernel build: 2.2.14 #10 Tue Nov 21 11:37:36 GMT-5 2000
>   options:  none
> /lib/modules/2.2.14/pcmcia/i82365.o: /lib/modules/2.2.14/pcmcia/i82365.o: No
> suyds: no socket drivers loaded!
> /lib/modules/2.2.14/pcmcia/ds.o: init_module: Device or resource busy
>  cardmgr.
> cardmgr[74]: starting, version is 3.1.19
> sh-2.03# cardmgr[74]: no pcmcia driver in /proc/devices
> cardmgr[74]: exiting
>
> sh-2.03# lsmod
> Module                  Size  Used by
> pcmcia_core            38032   0
> sh-2.03#
> -----------------------------------------
> I was under the impression from your previous post that the socket driver
> was part of the patch...am I mistaken?  If it is...I assume I must load it
> first...what is it called?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
