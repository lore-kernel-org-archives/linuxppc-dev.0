From: "Michael Fischer" <fischi@epygi.de>
To: "Julien Eyries" <julien.eyries@thales-bm.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: [Fwd: Re: kernel command line for CRAMFS root filesystem]
Date: Thu, 6 Jun 2002 17:30:01 +0200
Message-ID: <OEEHJMIIDJHHMFGGDNGDIEGLCOAA.fischi@epygi.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <3CFF7496.6050904@thales-bm.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,
> i have never mounted it before .
maybe you should try it from shell first to see if the cramfs is ok.

>
> i am currently booting with initrd (good :-)) from my flash and it works
> fine( the commandline was : root=/dev/rd/0 );
> but now i want to replace that with a cramfs (better :-)) .
>
> anyway, i know i can acess to the range (start 0xfe100000 - length
> 2MBytes) via my partition /dev/mtdblock/2 but if i try something like :
>    root=/dev/mtdblock/2 then JFFS2 try to mount it as root filesystem and
> fails !!!!!!
>
> maybe i should add something to the commandline, in order to tell the
> kernel that /dev/mtdblock/2 contains a CRAMFS partition ??
we use cramfs here and it works without additional parameter. How do you
generate the cramfs and on which kind of system are you using it? The
mkcramfs tool has an endianess problem so if you do mkcramfs on 86x platform
to use it on ppc it wont work. (maybe there is some newer version i am not
aware of where that is fixed)

Hope that helps,
good luck and best regards,
Michael


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
