Date: Thu, 1 Jul 1999 21:05:22 -0400 (EDT)
From: Anirudh Joshi <ajoshi@Glue.umd.edu>
To: Barrie Spence <barrie@calvin.demon.co.uk>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: cc/gcc/egcs kernel compilation options?
In-Reply-To: <199907012249.XAA05762@calvin.demon.co.uk>
Message-ID: <Pine.GSO.4.10.9907012103260.4766-100000@digital.eng.umd.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



	we use -msoft-float (notably for kernel builds) becuase the kernel
has problems with fpu ops and things go crazy, build without -msoft-float
and you'll find out :)
	i'm not sure if -mcpu=60X will do much good for kernel builds,
but for most others it should be fine, all it does is add a bunch of
'good' optimizations suggested.



ani




On Thu, 1 Jul 1999, Barrie Spence wrote:

> 
> As a PPC newbie, why do we need/use "-msoft-float"? Is this 
> to handle some processor implementations that don't have 
> floating-point hardware? (and if so, does it have any overhead 
> on the 603/604/G3 Macs?). If it does have some cost, could it 
> not be enabled in the same way as on Intel?
> 
> Next question, is there any advantage to building a kernel
> with "-mcpu=604 -mtune=604"? (or whatever is most appropriate).
> 
> Thanks,
> 	Barrie
> 
> 
> --
> Barrie Spence			Sanity Clause? There is no Sanity Clause
> Home: barrie@calvin.demon.co.uk		Telephone +44 1506 442304
> Play: b.spence@computer.org		

> 


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
