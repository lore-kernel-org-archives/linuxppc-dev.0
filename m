Date: Thu, 4 Feb 1999 16:38:14 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Andreas <toa@pop.agri.ch>
cc: "linuxppc-user@lists.linuxppc.org" <linuxppc-user@lists.linuxppc.org>,
        "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Compiling option for LinuxPPC
In-Reply-To: <36B96117.8806C50E@pop.agri.ch>
Message-ID: <Pine.LNX.4.03.9902041637590.9956-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 4 Feb 1999, Andreas wrote:
> does under LinuxPPC a compiler option /preprocessor symbol exist in the manner
> as it does under FreeBSD?
> 
> i.e. __FreeBSD__ or in LinuxPPC __LinuxPPC__??

defined(__linux__) && defined(__powerpc__)

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
