Mime-Version: 1.0
Message-Id: <v04210100b3c932b2cad2@[192.168.0.1]>
In-Reply-To: <Pine.LNX.4.10.9907311531450.420-100000@cassiopeia.home>
References: <Pine.LNX.4.10.9907311531450.420-100000@cassiopeia.home>
Date: Sat, 31 Jul 1999 15:16:48 -0800
To: Geert Uytterhoeven <geert@linux-m68k.org>
From: Ethan Benson <erbenson@alaska.net>
Subject: Re: Open Firmware booting on a Blue G3
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 31/7/99 Geert Uytterhoeven wrote:

>I have a FAT /boot partition on my CHRP box for this purpose.

yuk :-)

> > At 16:16 -0800 28/7/99, Ethan Benson wrote:
> > >well one reason that would be good to have quik around is quik makes
> > >setting up kernel images much easier then mucking around in OF
> > >(something people seem to have a problem with given all the
> > >slobbering over BootX) and quik could be given the same security and
> > >password controls that LILO has, with OF being totally unprotectable
> > >it is difficult to prevent someone from booting linux into single
> > >user mode, if the only way to enter single user mode was by passing
> > >'single' at the quik prompt then quik can be set to ask a passwd
> > >when arguments are given (just like restricted lilo)
>
>Decent OF implementations allow to set a password.

Apple's do not, (at least not as far as I have found) and even if it 
did Apple "helpfully" added the ability to erase the entire nvram by 
holding command-option-p-r at bootup

that means the only possibility to add even a little bit of security 
to the boot sequence is with quik, which is IMO a good enough reason 
to keep it and fix it for the new firmware.  the filesystem issue is 
also plenty reason enough, making ISO or FAT partitions to hold the 
kernel is horridly sloppy IMNSHO and should be avoided if at all 
possible. (in this case its very possible: keep quik.)

>The question arise whether even the latest Apple implementations of OF are
>decent. Do they have a decent `see' implementation these days?
>I could completely reverse engineer my OF by using `see', if I'd want to...

the Blue G3 OF is considered decent (other then the Apple TMed no 
security) by at least I few I have talked to, I am not sure what you 
mean by "decent `see' implementation, I have found see seems to work 
fine, maybe you could be more specific about what was broken in see?



Best Regards,
Ethan Benson
To obtain my PGP key: http://www.alaska.net/~erbenson/pgp/

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
