Date: Thu, 26 Feb 2004 16:18:39 +0100 (CET)
From: Marius Groeger <mgroeger@sysgo.com>
To: Prabhakar Kalasani <kalasani@sena.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: How to set up KGDB
In-Reply-To: <NCEHKHHDAHEBBGFMCFHCCEHCCBAA.kalasani@sena.com>
Message-ID: <Pine.LNX.4.56.0402261615030.14226@mag.sysgo.com>
References: <NCEHKHHDAHEBBGFMCFHCCEHCCBAA.kalasani@sena.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 26 Feb 2004, Prabhakar Kalasani wrote:

> I have a customised target board with MPC855t Processor , ppcboot-1.1.3
> bootloader , linux-2.4.2 kernel. I'm new to this environment, I got to set
> up KGDB for this target.can anybody please help me how to go about .
...
> If i boot the Image from Teratem(Remote) , I'm getting log like....
>
> Bootloader 1.1.3 (Dec 10 2003 - 17:02:39)
..
> =>setenv bootargs
> =>tftpboot
> ARP broadcast 1
> TFTP from server 192.168.222.208; our IP address is 192.168.161.5
> Filename 'zImage.vts8nfs.v1.4.1'.
> Load address: 0x100000
> Loading: #################################################################
>          ###############################################################

Just a guess: This looks *a lot* like the well-known U-Boot bootloader
in disguise (see http://sf.net/projects/u-boot). U-Boot usually
doesn't run zImages (vmlinux kernel + some glue code). Could be that
you are booting a wrong image. Go inside your kernel tree and try a
"make pImage" and boot that.

Regards,
Marius

--
Marius Groeger <mgroeger@sysgo.com>
Project Manager

SYSGO Real-Time Solutions AG | Embedded and Real-Time Software
Am Pfaffenstein 14
55270 Klein-Winternheim, Germany

Voice: +49-6136-9948-0 | FAX: +49-6136-9948-10
www.sysgo.com | www.elinos.com | www.osek.de

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
