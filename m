Date: Fri, 23 Apr 1999 13:04:18 +0200 (MET DST)
From: David De Ridder <s970707@uia.ua.ac.be>
Reply-To: David De Ridder <david.de.ridder@bitsmart.com>
To: Gabriel Paubert <paubert@iram.es>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Un-Setting VME3PCI Master Master Enable on MVME2431
In-Reply-To: <Pine.HPP.3.96.990421202724.20020d-100000@gra-ux1.iram.es>
Message-ID: <Pine.SO4.4.05.9904231252120.14515-100000@hsins.uia.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 21 Apr 1999, Gabriel Paubert wrote:
> On Wed, 21 Apr 1999, Simone Piccardi wrote:

> > We finally get a dataway display that cannot work. After many attempts
> > to use it (it was perfectly working in other crates) we try to go back
> > to the default configuration of the board (I switched to VME3PCI Master
> > Master Enable = N according to what said in the mailing list to boot the
> > kernel) and everything went working.
> > The manual said:
> > N do not enable the VME Bus Interface
> > 
> > So is this only related to the PPCBug (and with a working kernel all
> > will be OK?) Or I have to worry?
> 
> Don't worry. The settings of the Raven/Hawk are not ideal for large VME
> systems and it's better to enable the Universe later in the boot process
> or when loading the driver. This bridge is simply a PCI space hog,

 I have a report concerning VME3PCI myself : when it is set to ``N'',
 the ``SYSFAIL'' LED in our crate lights, and stays lit. I have been
 told this is bad, because it indicates that there will be no VME
 transfers possible between the MVME board and other VME devices.
 However, once the universe driver is loaded (e.g., through modprobe),
 the LED unlights. I assume this is because the Universe chipset is
 then correctly initialised, right ?

Regards,

+-----------------------------------------------------------------+
   David 'Septimus' De Ridder     <david.de.ridder@bitsmart.com>

"Blow the world apart with a press of a button
 we all say it shouldn't but we know it will happen.
 Again and again, like the rain and the ark :
 almost forever, eternally dark."
 - Anne Clark
+-----------------------------------------------------------------+


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
