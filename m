Date: Wed, 21 Apr 1999 20:58:00 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Simone Piccardi <Simone.Piccardi@fi.infn.it>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Un-Setting VME3PCI Master Master Enable on MVME2431
In-Reply-To: <371E0313.C0FF665C@fi.infn.it>
Message-ID: <Pine.HPP.3.96.990421202724.20020d-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Wed, 21 Apr 1999, Simone Piccardi wrote:

> 
> Hi,
> today I got another "little" trouble with our board.
> We finally get a dataway display that cannot work. After many attempts
> to use it (it was perfectly working in other crates) we try to go back
> to the default configuration of the board (I switched to VME3PCI Master
> Master Enable = N according to what said in the mailing list to boot the
> kernel) and everything went working.
> The manual said:
> N do not enable the VME Bus Interface
> 
> So is this only related to the PPCBug (and with a working kernel all
> will be OK?) Or I have to worry?

Don't worry. The settings of the Raven/Hawk are not ideal for large VME
systems and it's better to enable the Universe later in the boot process
or when loading the driver. This bridge is simply a PCI space hog,
actually if you sum the maximal size of all the programmable images you
would get something slightly over 32 Gb so it's better to disable it when
playing with the host bridge (not yet fully done). 

> Probably this is a stupid question, but as I said I'm totally new to
> VME.

No problem. We all have been newbies at some point. 

	Gabriel


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
