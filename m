Message-Id: <200010191513.LAA25626@mal-ach.watson.ibm.com>
To: Gabriel Paubert <paubert@iram.es>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Nelson Abramson <pogtal@erols.com>, Jean-Jacques.Levy@inria.fr,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: video mirroring mode + acrobat reader 
In-Reply-To: Message from Gabriel Paubert <paubert@iram.es>
   of "Thu, 19 Oct 2000 16:22:32 +0200." <Pine.HPX.4.10.10010191619560.3208-100000@gra-ux1.iram.es>
Date: Thu, 19 Oct 2000 11:13:26 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Gabriel Paubert writes:

Gabriel> Maybe Linux/PPC binaries can be made to run under AIX ?

	With the start addres change, running PowerPC Linux binaries in a
compatibility mode under AIX is possible.  At the earlier address, the
executables loaded at the top of the AIX kernel segment which was
impractical to overcome in AIX.

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
