Date: Thu, 15 Apr 1999 21:02:17 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Simone Piccardi <Simone.Piccardi@fi.infn.it>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: First attempt for LinuxPPC on a MVME2400
In-Reply-To: <371621E6.F54F8019@fi.infn.it>
Message-ID: <Pine.HPP.3.96.990415204745.1720F-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Thu, 15 Apr 1999, Simone Piccardi wrote:

> 
> As first thank to all people that helped me (but I think this is only
> the beginning!).
> The first step was to set the environment )PPC4bug> ENV) for booting
> PReP using the options:
> Network PReP-Boot Mode Enable = Y
> and 
> VME3PCI Master Master Enable = N

What is the output of VER under PPCBug ? 

This is to get the chip identifier for the HAWK, on my board I get towards
the end: 
PCI Bus Bridge Device ID/Revision...................=48011057/01                
PCI Function 00/0B/0 (00005800) ID/Revision.........=056510AD/04                
PCI Function 00/0B/1 (00005900) ID/Revision.........=010510AD/05                
PCI Function 00/0C/0 (00006000) ID/Revision.........=00031000/13                
PCI Function 00/0D/0 (00006800) ID/Revision.........=000010E3/00                
PCI Function 00/0E/0 (00007000) ID/Revision.........=00091011/22                
PCI Function 00/10/0 (00008000) ID/Revision.........=88115333/54                

this mighht be necessary to be able to recognize the Hawk. Obviously the
fault you have is due to the fact that the OpenPIC is not found.

Then there might be problems with the network interface, but they will 
only when the interrupt controller problems are solved. 

	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
