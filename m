Date: Tue, 20 Apr 1999 15:57:56 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: David De Ridder <david.de.ridder@bitsmart.com>
cc: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: MVME zImage works
In-Reply-To: <Pine.SO4.4.05.9904201546000.3400-100000@hsins.uia.ac.be>
Message-ID: <Pine.HPP.3.96.990420155448.20020G-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Tue, 20 Apr 1999, David De Ridder wrote:

> * download Gabriel's MVME patches (both generic and vme), and applied
>   them both to the source tree. (First generic, then vme).
> * download Gabriel's MVME config.nfsroot
> * ``make mrproper''
> * ``make oldconfig'' using the config.nfsroot
> * ``make zImage''. This goes flawless, with the resulting kernel image
>     in arch/ppc/prepboot/zImage
> * ``make modules'' fails (because of universe.c -- to be solved soon, I
>    hope). The modules missing isn't really a problem since almost
>    everything you need should be in the kernel image.

solved but you'll need to upgrade to 2.2.6.

> I've fed this kernel to my TFTP server, rebooted the board, and voila, I
> had my own 2.2.4 kernel, compiled on the board.
> 
> (Gabriel, I have another question : I noticed you updated the .config's
>  on your site. Are they for 2.2.4 or for 2.2.6 ?)

They are for 2.2.6, although there are very few differences. Actually make
oldconfig did not ask any questions when updating the nfsroot config to
2.2.6. For the other, the only question is related to tyhe split of the
Symbios/NCR driver and you should answer N (the new one does not work for
now). 

	Gabriel.


> People who want to try this too, can find all the Web links they need at :
> 
>  http://win-www.uia.ac.be/u/s970707/thesis/archive.html

Thanks for putting this up.

	Regards,
	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
