From: "Jack Howarth" <howarth@bromo.med.uc.edu>
Message-Id: <9905171735.ZM1161@bromo.med.uc.edu>
Date: Mon, 17 May 1999 17:35:34 -0400
To: linuxppc-dev@lists.linuxppc.org
Subject: linux 2.2.8/2.2.9 oddities
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


   Is anyone else seeing oddities in the graphics of Linux 2.2.8
and 2.2.9 on G3s? Under the new Reference Release 1.0, the supplied
Linux 2.2.6 kernel works fine however when I build either 2.2.8
or 2.2.9 from the kernel sources I have the following problem.
When using bootx with the kernel flags below...

video=atyfb:vmode:13,cmode=1 adb_buttons=1

...which always as worked fine in the past, the video comes up
with the console text shifted over by about 4/5ths to the right
of the screen and wrapped around from the left. It would seem
that something is broken now in atyfb.
                Jack

-- 
------------------------------------------------------------------------------
Jack W. Howarth, Ph.D.                                     231 Bethesda Avenue
NMR Facility Director                              Cincinnati, Ohio 45267-0524
Dept. of Molecular Genetics                              phone: (513) 558-4420
Univ. of Cincinnati College of Medicine                    fax: (513) 558-8474

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
