In-Reply-To: <Pine.LNX.4.10.9908241456210.17842-100000@mercator.cs.kuleuven.ac.be>
Date: Tue, 24 Aug 1999 15:05:58 +0200
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>,
        linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: BootX enhancement request
Message-Id: <19990824150558.006009@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Aug 24, 1999, Geert Uytterhoeven
<Geert.Uytterhoeven@cs.kuleuven.ac.be> wrote:

>Thus I can remove the nvram code from atyfb?

Depending on the version of MacOS, and if the user uses or not the old
"Monitors" control panel, it may still be useful. On my PowerBook, I
always had to set the resolution in the kernel command line, but I think
that the vram stuff still works on my 8500 (controlfb). 

I beleive the nvram code is useless on iMacs and blue G3s.

-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>

--GAG19404.935596886/motgate.mot.com--

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
