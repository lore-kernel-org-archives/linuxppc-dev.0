Subject: Re: boot methods
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
To: paulus@samba.org
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <15302.40082.869098.88039@cargo.ozlabs.ibm.com>
References: <15302.40082.869098.88039@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: 13 Oct 2001 13:01:59 +0200
Message-Id: <1002970919.7091.1849.camel@pismo>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2001-10-12 at 09:32, Paul Mackerras wrote:
>
> I would like to make a complete list of the methods people use to boot
> the PPC/Linux kernel on different platforms.  As a start, here is what
> I can think of off the top of my head:
>
> Powermac:
> 	vmlinux loaded with BootX
> 	vmlinux loaded with quik
> 	vmlinux loaded with yaboot
> 	vmlinux.coff loaded via OF netboot
> 	vmlinux.elf-pmac loaded via OF (disk or net boot)
>
> RS/6000 CHRP:
> 	vmlinux loaded with yaboot
> 	zImage.chrp-rs6k loaded via OF netboot
>
> RS/6000 43p-140:
> 	zImage.prep loaded via OF (floppy or hard disk)

APUS:
	vmlinux loaded with boothack (from AmigaOS)


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
