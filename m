Date: Fri, 23 Apr 1999 13:23:25 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: David De Ridder <david.de.ridder@bitsmart.com>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Un-Setting VME3PCI Master Master Enable on MVME2431
In-Reply-To: <Pine.SO4.4.05.9904231252120.14515-100000@hsins.uia.ac.be>
Message-ID: <Pine.HPP.3.96.990423131932.20020w-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Fri, 23 Apr 1999, David De Ridder wrote:

>  I have a report concerning VME3PCI myself : when it is set to ``N'',
>  the ``SYSFAIL'' LED in our crate lights, and stays lit. I have been
>  told this is bad, because it indicates that there will be no VME
>  transfers possible between the MVME board and other VME devices.
>  However, once the universe driver is loaded (e.g., through modprobe),
>  the LED unlights. I assume this is because the Universe chipset is
>  then correctly initialised, right ?

Indeed. The driver resets the SYSFAIL signal and the associated pending
interrupts on init (Actually Universe initialization is a very complex
topic, it's easy to get conflicts in PCI memory space).

	Regards,
	Gabriel. (progressing slowly on the doc for the Universe driver)



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
