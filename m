Date: Thu, 22 Apr 1999 19:21:35 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Simone Piccardi <Simone.Piccardi@fi.infn.it>
cc: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: MVME2306 : kernel 2.2.6 SUCCESS !
In-Reply-To: <371F76F4.27B2850D@fi.infn.it>
Message-ID: <Pine.HPP.3.96.990422191551.20020q-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>





	Hi,

On Thu, 22 Apr 1999, Simone Piccardi wrote:

> I made the correction you suggested, and that time make zImage compiled
> well the routine, but then it stopped a bit further when doing vmlinuz
> and zImage.
> This was due to these two lines:
> 
> ld -o zImage $(OBJECTS) --just-symbols=$(TOPDIR)/vmlinux
> 
> objcopy $(TOPDIR)/vmlinux vmlinux -O binary -R .comment -S
> 
> in /home/ppc/linux/arch/ppc/prepboot/Makefile
> 
> That just don't work on my PC, because in this way the makefile is using
> the intel tools, I modified in: 
> 
> $(CROSS_COMPILE)ld -o zImage $(OBJECTS) --just-symbols=$(TOPDIR)/vmlinux
> 
> $(CROSS_COMPILE)objcopy $(TOPDIR)/vmlinux vmlinux -O binary -R .comment
> -S
> 
> and everything went fine. So now I can start to do check with your
> images.

Symbols $(LD) and $(OBJCOPY) are already defined, it's better to use them. 
I've fixed it in my tree. 

Thanks for the report. 
	
	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
