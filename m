Date: Tue, 20 Apr 1999 14:06:02 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Matt Porter <mmporter@home.com>
cc: Simone Piccardi <piccardi@fi.infn.it>, linuxppc-dev@lists.linuxppc.org
Subject: Re: LinuxPPC on a Motorola MVME2400
In-Reply-To: <Pine.LNX.3.96.990409085312.32668A-100000@liberty.chnd1.az.home.com>
Message-ID: <Pine.HPP.3.96.990420140134.20020C-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Fri, 9 Apr 1999, Matt Porter wrote:

> Programming is the same as Falcon/Raven since it just integrates them.
> The only thing that is needed is perhaps to detect it in your OpenPIC
> code.  We are using a different OpenPIC patch as well as some stuff to
> detect all the MCG boards and set interrupt routing properly.  Hopefully
> it can get rolled in soon.
> 
> This really sucks that some of us are working from official tarballs and
> some are working from vger. :-/  Though I do understand your bandwidth
> constraints to the U.S.

Ok, thanks. It seems the BW situation is improving. But I'll wait until
the release of the VME driver before going back to vger. I've been bitten
very hard in January when vger was closed and had to go back to
official tree. Is there such a big diff between vger and Linus since 2.2.4
(which was painful enough to apply on my tree) ? 


BTW: which bootloader do you use ? I'm going to make significant changes
to prepboot soon (switching to a CHRP like map when a Raven/Falcon/Hawk
is found) ?

	Regards,
	Gabriel.


> 
> --
> Matt Porter
> mmporter@home.com
> This is Linux Country. On a quiet night, you can hear Windows reboot.
> 
> 


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
