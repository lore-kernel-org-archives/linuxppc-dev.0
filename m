Date: Sat, 19 Jun 1999 14:22:36 -0400 (EDT)
From: "P. Barrette" <barretp@mcmail.cis.McMaster.CA>
To: Akiko Tanaka <tanak002@gold.tc.umn.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: a question
In-Reply-To: <376BA9B3.6773@gold.tc.umn.edu>
Message-ID: <Pine.SOL.3.96.990619142028.669D-100000@mcmail.cis.McMaster.CA>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I think you need to put it in the main directory, ie. just drop it on the
"Macintosh HD" hard drive icon.  It should be in the same area as your
system folder.  Re partitions, hda5 should be right, I don't know about
the ata stuff though.

--------
Paul Barrette
Ph.D. Candidate Classics (Latin Literature)
System Administrator
McMaster University

"Oppositaque ad os manu nescio quid taetrum 
exsibilavit, quod postea Graecum esse affirmabat."
                                      --Petronius

On Sat, 19 Jun 1999, Akiko Tanaka wrote:

> 
> I've been tryint to install Linux (downloaded from 
> mklinux.apple.com/pub site) on my Mac (power Mac 5400), but it seems 
> like I don't know the basics that the READ ME's and your FAQ's don't 
> explain, and am having trouble for hours.  The problem I have is the 
> "bootstrap cannot find configuration file" message that I get, which 
> seems to be a common problem.  But, I think my problem is that I Don't 
> know how to do "4) Place the "mach_servers" folder at the top level 
> (ie. not on the desktop)
>    of a suitable volume on your Mac."  Am I supposed to put 
> "mach_server" folder inside the patrition for MacHFS when I look at 
> through the pdisk?  How do you do that?  I just don't know how to put 
> things above the desktop level.
> 
> Also, if I manage to put it where it's supposed to go and edit the 
> line in lilo.conf, am I supposed to just put rootdev=/dev/hda (or 
> ata0.0) or whatever, or supposed to write 
> /dev/boot_device/mach_servers/bootstrap.conf, which comes up in the 
> error message when I try to boot it?  Also, it seems that I have to 
> specify a patition when I do this.  How do I do that?  If the 
> patrition # in pdisk is 5, do I put rootdev=/dev/hda/5 or hda5? or 
> what?  If it's ata0.0, does it become ata0.5 or ata0.0/5 or some other 
> kind of way?
> 
> Please Help!!
> 
> Akiko Tanaka
> tanak002@gold.tc.umn.edu

> 


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
