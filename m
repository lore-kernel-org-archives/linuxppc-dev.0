Message-Id: <199907201636.LAA22308@lists.linuxppc.org>
Date: Tue, 20 Jul 1999 18:41:58 +0100
Subject: Re : X : caught signal 11 ?
From: "Yann Bizeul" <yann@tynsoe.com>
To: Chris Baker <cbaker@adrenalin.com>,
        Hollis R Blanchard <hollis+@andrew.cmu.edu>
CC: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>
>> I also have problem 1), though I guess I've managed to disable xscreensaver
so
>> X does its built-in blanking thing (with no power saving =( ).
>
> I'm assuming you mean something along the lines of
>
> $ xset s off
>
> Does X have a built in blanking thing other than that?  Or is it an Apple
hardware
> thing?

Ok, I did xset -s off, and it prevents xscreensaver from launchin...

Tha good question is about the built-in blanking :

All the time under R4, the screen (under X or console) goes black itself,
but I notice that under X, with R5, the screen does not fade out, but it
does in the console ?

hu ?

do ya understand something ?
>
>>
>>
>> To crash X:
>> startx
>> ctrl-cmd-F1
>>
>> Poof. All gone. If you have xdm set up, xdm reloads (and takes you to vc 7
>> from wherever you wanted to go in the first place). I'm using platinumfb. Is
>> anyone else out there able to use virtual consoles without X crashing?
>
> I can switch consoles o.k. I'm on a pb3400c so I guess that makes me
chips65550fb
> (?).  If I put the machine to sleep for any significant period of time, X
dies.
>
> Is this just an xfree problem or is it in xpmac also?
>
> cheers,
>
> cbb
>
>
>
> [[ This message was sent via the linuxppc-user mailing list. Replies are ]]
> [[ not forced back to the list, so be sure to  Cc linuxppc-user  if your ]]
> [[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
> [[ and http://www.linuxppc.org/ for useful information before posting.   ]]
>
> 

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
