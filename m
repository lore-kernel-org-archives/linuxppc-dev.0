Date: Tue, 15 Jul 2003 00:40:23 -0400
From: Bill Fink <billfink@mindspring.com>
To: LinuxPPC Developers <linuxppc-dev@lists.linuxppc.org>
Cc: daronin@digimerc.com, Bill Fink <billfink@mindspring.com>
Subject: Re: firewire in 2.4.21-ben2
Message-Id: <20030715004023.5003a455.billfink@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 14 Jul 2003, daRonin wrote:

>  I just upgraded to 2.4.21-ben2 kernel. And I can't mount my firewire
> HDDs any longer.
>
> These are the commands I am executing:
>
> modprobe -k ieee1394
> modprobe -k ohci1394
> modprobe -k sbp2
> modprobe -k raw1394
> modprobe -k sd_mod
> mount /dev/sda2 /mnt/fire
>
> Judging by the logs everything seems to go fine up to inserting sd_mod.
> sbp2 module seems to see the device and such.
>
> But after inserting sd_mod absolutely nothing happens. I tried rmmod'ing
> the modules and inserting them again, tried to switch the order around,
> etc. No luck...
>
> After I reboot back in 2.4.20-ben10 everything works fine...

Run rescan-scsi-bus.sh.

						-Bill

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
