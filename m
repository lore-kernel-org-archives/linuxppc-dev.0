In-Reply-To: <Pine.HPX.4.10.9908271248020.9440-100000@gra-ux1.iram.es>
Date: Fri, 27 Aug 1999 15:17:48 +0200
To: Gabriel Paubert <paubert@iram.es>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: CHRP boards and VGA text mode.
Message-Id: <19990827151748.028421@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Aug 27, 1999, Gabriel Paubert <paubert@iram.es> wrote:


>- Make the kernel code loaded at 640 k physical (except for the interrupt
>vectors...). There is no way to build a kernel with less than 384k of
>code (my nfsroot kernels are truly minimal). Reserve the first 16 kB or so 
>for interrupt handlers/whatever, then 624k of normal memory followed by
>the kernel and then higher memory. I would actually prefer this solution,
>but feel free to suggest any other...

Side note: having the ability to locate the kernel at a different address
than the exception vectors would help the NuBus port.

-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
