Date: Wed, 25 Aug 1999 20:45:56 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@mvista.com>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: Tony Mantler <eek@escape.ca>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Performa 5200
In-Reply-To: <19990825122335.016707@mail.mipsys.com>
Message-ID: <Pine.LNX.3.96.990825204441.30523B-100000@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 25 Aug 1999, Benjamin Herrenschmidt wrote:

> all the x100 machines have address maps that depends on the population of
> the RAM slots. Also, some of them have a DRAM-based frame buffer working
> at a fixed physical address which can be either 0 or 1Mb.
> BootX will load the kernel in the first contiguous region in memory it
> can find, but that means that we have to copy the exception vectors to 0,
> adjust them so they call correctly the kernel routines in the real base
> of the kernel (which will not be 0 on some machines), and we'll have
> virt_to_phys and co be non-constant. I read an interesting suggestion
> some time ago of reserving a register during kernel compile with gcc and
> using this register to store the real base of the kernel. Modules will
> not be compatible, but that's not a real issue for now.
> I don't know how the APUS code works, but I heard it is similar.

Wait a sec.  Don't you have code to remap the video to 1 meg?


David


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
