From: "Jack Howarth" <howarth@bromo.med.uc.edu>
Message-Id: <9906061823.ZM27563@bromo.med.uc.edu>
Date: Sun, 6 Jun 1999 18:23:47 -0400
In-Reply-To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
        "gdb 4.18-1" (Jun  6,  9:47pm)
References: <Pine.LNX.4.10.9906062143070.4301-100000@mercator.cs.kuleuven.ac.be>
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
Subject: Re: gdb 4.18-1
Cc: linuxppc-dev@lists.linuxppc.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert,
   I don't believe they should be using gdb 4.18. That version of gdb lacks
the changes HJ Lu made to the latest version of 4.17.x. According to HJ, 
because of the complexity of moving the last 4.17.x patches into 4.18
they avoided doing so until after its release. Thus 4.18 is no good for
linuxppc until the latest 4.17.x patches have been ported to it. I don't
know what the status of this is.
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
