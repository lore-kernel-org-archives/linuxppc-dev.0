Date: Fri, 9 Apr 1999 12:35:37 +0200
From: massin@col.bsf.alcatel.fr (Raphael Massin)
Message-Id: <199904091035.MAA03310@c5s144.clb>
To: eramdam@kieray1.p.y.ki.era.ericsson.se
Subject: Re: embedded linux
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> hi there!
> 
> it seems like you've come a long way using embedded linux.
> i've got the same problem with libc as you have.
> but no answer, sorry.
> i'm stuck with my kernel.
> 
> could you please tell me what kind of board you are using?
> you probably run it on homebuilt hardware, and that brings me
> to my real question:
> 
> do you run linux from ata-disk or via nfs and linux works?

My turn to be sorry:-), i run linux without hard drive nor nfs.

> i've got a mbx-board that runs linux without any problems.
> the other motorola boards (fads, ads), they all hang using
> nfs-root or using ata-flash.
> 
> i've written the boot-code myself.
> 
> have you written the boot-code for the 860 yourself

Yes, in fact on my board, the zvmlinux is loaded via a backpannel
and uses a RAM file system as root file system (the ram file system code
has been modified to get its image from a section in the vmlinux image)

> and do you have any experience you would like to share with me?

I can do nothing for your ata-disk or nfs, but i would be pleased to help

> i think my problem is that i don't get any page-faults when loading binaries.

??

> 
> thanks /
> 
> magnus

	Raphael 


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
