Date: Fri, 23 Apr 1999 18:28:06 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Simone Piccardi <Simone.Piccardi@fi.infn.it>
cc: Matt Porter <mmporter@home.com>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: A still not working, but cross-compiled kernel
In-Reply-To: <37209E59.BE289D2E@fi.infn.it>
Message-ID: <Pine.HPP.3.96.990423181514.20020C-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Fri, 23 Apr 1999, Simone Piccardi wrote:

> Hi,
> 
> Thanks to all your suggestion and help I finally get out from the kernel
> cross-compilation; I obtained a zImage file that boot in the same manner
> of the Gabriel Paubert images (i.e. still crash on the ethernet deriver,
> but in the same way), so at least I can be confident that the
> cross-compilation procedure is going right.
> 
> Next problem is to get the ethernet working: I tries to change the
> ethernet setting as suggested; the output of the SROM command is this:
> 
> PPC4-Bug>srom
> 
> Device Address =$00007000 (N/Y)? y
> Reading SROM into Local Buffer.....
> $00 (&000) 0000?
> $02 (&002) 0000?
> $04 (&004) 0000?
> $06 (&006) 0000?
> $08 (&008) 0000?
> $0A (&010) 0000?
> $0C (&012) 0000?
> $0E (&014) 0000?
> $10 (&016) AF00?
> $12 (&018) 0301?
> $14 (&020) 0800?
> $16 (&022) 3E28?
> $18 (&024) 2800?
> $1A (&026) 0E1E?
> $1C (&028) 0000?
> $1E (&030) 0008?	<---- Is this one?

No. 

> $20 (&032) 0193?
> $22 (&034) 0308?
               ^^ 
               That one.

> $24 (&036) 0003?
> $26 (&038) 0108?
> $28 (&040) 0000?
> $2A (&042) 0100?
> $2C (&044) 0078?
> $2E (&046) E001?
> $30 (&048) 0050?
> $32 (&050) 0018?


The rest looks ok. 

> I tried to put on 1E location (that one marked above) the value 0 but
> the results were the same of before the changes, the kernel crash:

No that one means autonegotiation of link parameters.

> I tried also to apply the Matt Porter patch for dec21143 to my kernel
> tree, but it didn't work (probably because it's based on kernel 2.2.5
> and I'm using a 2.2.6 patched kernel). 
> 
> Still I'm working on setting up the bootp server and to build the root
> tree, but I don't think that this can cause the crash of the system.

No. I can help you wit this too. And I hope we'll soon be wroking on the
VME side of the board once all these problems are solved.

	Regards,
	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
