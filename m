Message-ID: <37412A00.3F815281@iwate-u.ac.jp>
Date: Tue, 18 May 1999 18:51:13 +1000
From: Piotr Muszynski <u0295020@iwate-u.ac.jp>
MIME-Version: 1.0
To: Jack Howarth <howarth@bromo.med.uc.edu>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: linux 2.2.8/2.2.9 oddities
References: <9905171735.ZM1161@bromo.med.uc.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Jack Howarth wrote:

>    Is anyone else seeing oddities in the graphics of Linux 2.2.8
> and 2.2.9 on G3s? Under the new Reference Release 1.0, the supplied
> Linux 2.2.6 kernel works fine however when I build either 2.2.8
> or 2.2.9 from the kernel sources I have the following problem.
> When using bootx with the kernel flags below...
>
> video=atyfb:vmode:13,cmode=1 adb_buttons=1
>
> ...which always as worked fine in the past, the video comes up
> with the console text shifted over by about 4/5ths to the right
> of the screen and wrapped around from the left. It would seem
> that something is broken now in atyfb.
>                 Jack
>
> --
> ------------------------------------------------------------------------------
> Jack W. Howarth, Ph.D.                                     231 Bethesda Avenue
> NMR Facility Director                              Cincinnati, Ohio 45267-0524
> Dept. of Molecular Genetics                              phone: (513) 558-4420
> Univ. of Cincinnati College of Medicine                    fax: (513) 558-8474

Good to know I'm not alone with this problem -- under kernels > 2.2.7 (vger),  on
the PowerMac7500/100(601).
I described the problem in the message "vger 2.2.7 and console" a few days ago.

Any ideas about trying ./MAKEDEV -update ?  That fixed floppy mounting under
2.2.7 for me...
Any good ideas :-) ?

piotru



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
