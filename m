Date: Wed, 17 Mar 1999 09:41:56 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: nathan ingersoll <ningerso@d.umn.edu>
cc: Tom Dilling <tdilling@oncodev.isc-net.upenn.edu>,
        linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org
Subject: Re: anon-CVS: HOW?
In-Reply-To: <Pine.SO4.4.02.9903162249200.13731-100000@ub.d.umn.edu>
Message-ID: <Pine.LNX.4.03.9903170941240.8496-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 16 Mar 1999, nathan ingersoll wrote:
> To update cd to the directory and type:
> 
> 	cvs update -d

Please make that

    cvs -z3 update -d

to enable compression.

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
