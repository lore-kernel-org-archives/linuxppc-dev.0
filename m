Message-ID: <374CCD26.AB2C6ADC@eos.ncsu.edu>
Date: Thu, 27 May 1999 00:42:14 -0400
From: Scott Sams <sbsams@eos.ncsu.edu>
MIME-Version: 1.0
To: jsproul@mail.wesleyan.edu, linuxppc-dev@lists.linuxppc.org
Subject: Re: AWACS Bug
References: <Pine.GSO.4.05.9905251646130.14882-100000@mail.wesleyan.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thank you for the helpful information. However, neither of the tricks
you suggested helped me. Is it possible to damage the AWACS chip on the
motherboard (maybe by an electrical surge?) and still have the machine
run? 

I guess I will have to install a new card. Do you know of any other PCI
sound cards that work under linuxppc on a powermac?

Thanks,

Scott

Jason Y. Sproul wrote:
> 
> Have you tried a motherboard reset and/or powerdown? For the former, you
> have to locate the reset switch on the motherboard - should be near the
> battery. For the latter, you have to yank the backup battery on the
> motherboard and leave it out and the machine unconnected to *anything* for
> at least four hours. (Overnight is preferable.) I've seen Macs get wedged
> badly enough that an mboard powerdown and a few hits of the reset were
> necessary to flush everything. Developing PCI cards isn't always fun...
> 
> ........................................................................
> Jason Y. Sproul                    http://www.con.wesleyan.edu/~jsproul/
> jsproul@wesleyan.edu            jsproul@iced.com    http://www.iced.com/
>      Eagles may soar, but weasels don't get sucked into jet engines.

-- 
 ____ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~      Scott Sams         
(____  _  _-|-|-                    sbsams@eos.ncsu.edu      
_____)(__(_)| |        http://www.catt.ncsu.edu/~sbsams
~~~~~~~~~~~~~~~~

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
