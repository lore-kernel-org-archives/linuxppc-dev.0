Date: Wed, 28 Jul 1999 07:53:21 -0500 (CDT)
From: "ian reinhart geiser (ADMIN)" <geiseri@msoe.edu>
To: Neil Jolly <jollyn@cadvision.com>
cc: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>,
        LinuxPPC List <linuxppc-user@lists.linuxppc.org>
Subject: Re: G3 Upgrade Questions....
In-Reply-To: <379E8995.31CA136B@cadvision.com>
Message-ID: <Pine.OSF.3.96.990728074858.32588A-100000@torres.msoe.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 27 Jul 1999, Neil Jolly wrote:

> 
> ian geiser wrote:
> 
> > Hello,
> >     I just installed a G3 upgrade card into my powercenter132
> >     It is a 400Mhz with 1Meg at 200Mhz....
> >     It registers under MacOS perfectly but i get the following under
> >     proc/cpuinfo:
> >     processor       : 0
> >     cpu             : 750
> >     temperature     : 0 C            <--Is this correct?!
> >     clock           : 195MHz        <-- Is this correct?!
> >     revision        : 130.1
> >     bogomips        : 399.77
> >     zero pages      : total 0 (0Kb) current: 0 (0Kb) hits: 0/1084 (0%)
> >     machine         : Power Macintosh
> >     motherboard     : AAPL,7300 MacRISC
> >     memory          : 112MB
> >
> >     it only registers 195 Mhz and 0C for the temp... is the correct?
> >     i am running Kernel 2.2.10
> 
> Here's a peek at my cpu info. A 233 G3 clocked to 292 with 83mhz bus, and
> runs around 106 degrees F. Obviously the temp is not accurate, but clock
> seems to be pretty close.
> 
> processor       : 0
> cpu             : 750
> temperature     : 0 C
> clock           : 290MHz
> revision        : 2.2
> bogomips        : 581.63
> zero pages      : total 0 (0Kb) current: 0 (0Kb) hits: 0/558 (0%)
> machine         : Power Macintosh
> motherboard     : AAPL,Gossamer MacRISC
> L2 cache        : 512K unified pipelined-syncro-burst
> memory          : 96MB
> 
	i have a powercenter 132, is it feasable that the 
	motherboard can only run a 200MHz CPU or is the
	card being set to half speed some how?

	under MacOS it says it is at 400 and when i run
	MacBench i get the numbers a little lower than
	what the box says ( like 25 points low ).

	under LinuxPPC my setiat home client takes almost
	24h to process a block while my P][ 400 takes
	only 10 hours....

	is this the client?
	am i really running half as fast?

	should i send this bugger back and just get
	a 200Mhz one because that is all my board can	
	do?

	thanks for the input all.

	-ian reinhart geiser
	

.-----------------------------------------------------------.
|[]                   NeXT Generation                    [X]|
|--------------------------,--------------------------------.
|  UNIX GEEK,              | Office:    I have none...      |
|  Macintosh Specialist @  | Phone:     414.277.7288        |
|  Milwaukee School of     |                                |
|        Engineering       |--------------------------------|
|                          |                                |
|   ian reinhart geiser    | phone:   414.220.9683          |
|   Apt #5                 | email:   geiseri@msoe.edu      |
|   828 N Milwaukee St     | web:     www.msoe.edu/~geiseri |
|   Milwaukee, WI 53202    |  NeXT/Be/Cyberdog Mail okay!   |
|                          |   MIME or BinHex preferred     |
|--------------------------'--------------------------------|
'-----------------------------------------------------------'


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
