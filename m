MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Basic Question
Date: Fri, 14 May 2004 14:45:15 -0600
Message-ID: <065ACD8E84315E4394C835E398C8D5EB092240@cossmgmbx02.email.corp.tld>
From: "VanBaren, Gerald (AGRE)" <Gerald.VanBaren@smiths-aerospace.com>
To: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of
> claudio.lazzarotto@copel.com
> Sent: Friday, May 14, 2004 9:38 AM
> To: Linuxppc-Embedded; Dan Malek; Wolfgang Denk; Joakim Tjernlund;
> sanjeevr@myw.ltindia.com
> Subject: Basic Question
>
>
>
> Hello people!
>
> I'm beginning to use Linux on embedded PowerPC and ...
> ... i want to get Linux installed on a powerPC board MPC850
> based system  equipped with the follow PPCBoot bootloader:
>
> PPCBoot 2.0.0 (Jul 21 2003 - 11:22:03)
>
> CPU:   XPC850xxZTB at 48 MHz: 2 kB I-Cache 1 kB D-Cache
> DRAM:  32 MB
> FLASH:  8 MB
> In:    serial
> Out:   serial
> Err:   serial
> Net:   SCC ETHERNET
>
> Where can I get a linux version and how can I have it
> ported to this board?
>
> Thanks
>
> Claudio A. Lazzarotto


Basic answers: U-Boot is the successor to PPCBoot.  Both are hosted on SourceForge.  You should switch to U-Boot, PPCBoot became U-Boot and is no longer actively maintained.
  http://sourceforge.net/projects/u-boot/

Wolfgang Denk has very good linux support that will help _you_ to port linux to your board.  See his Embedded Linux Development Kit (ELDK).
  http://www.denx.de/
  http://www.denx.de/twiki/bin/view/DULG/Manual
If you don't feel up to the job, there are several companies and probably more than a few freelance engineers willing to do it for a fee.  In terms of companies, Denx and MontaVista are the ones most visible in the U-Boot arena.

gvb


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
