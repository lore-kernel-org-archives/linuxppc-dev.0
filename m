Message-Id: <199908092113.XAA00412@piglet.cpu.lu>
Date: Mon, 9 Aug 1999 23:13:49 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Trying a Promise Ultra/66 on powerpc
To: drow@false.org
cc: Paul.Mackerras@cs.anu.edu.au, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <19990808232621.B352@them.org>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Dan,

I'm getting returned mail (user unknown) on Andre's email address. Do
you happen to know his new address?

On   8 Aug, this message from Daniel Jacobowitz echoed through cyberspace:
[Io port mapping funnies]
>
> This didn't, oddly, stop my card from working.  It does, however, make
> me lock up hard if I hdparm -i /dev/hda.

What is your machine? Any IDE devices onboard?

I'm getting lockups myself on hdparm -I and -d1 -X66 (for the Maxtor
drive) and at drive identification on bootup with a Quantum Fireball.
Weired....

> Oh, if you didn't pick this up, you can make it ide0/1 instead of
> ide2/3 by enable CONFIG_BLK_DEV_OFFBOARD.

Yeah, I was just too lazy to enable it, thanks ;-)

>> /dev/hde:
>>  Timing buffered disk reads:  64 MB in  6.60 seconds = 9.70 MB/sec
>> Maxtor 91024D4; 10G 7200 RPM, UDMA-2 ie 33 MB/s.
> 
> Eek.  I want that :)

Yeah, interesting drive, as it is _very_ silent; nothing to do with the
usual 7200 RPM stuff, plus it is relatively fast. And affordable ;-) 

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
