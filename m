Date: Wed, 14 Jul 1999 10:17:07 +0000
Message-Id: <v04003a00b3b227219c2b@[204.22.210.180]>
In-Reply-To: <v04020a02b3ac45cbc4ab@[192.168.0.2]>
References: <8xyagpbzxm.fsf@s53.informatik.uni-bremen.de> Mike DeSimone's
 message of Fri, 9 Jul 1999 08:04:03 -0500 Sacha Varma's message of Fri,
 09 Jul 1999 12:29:35 +0100 <3785DD1F.B853E731@ssl.co.uk>
 <v04020a00b3aba2034899@[192.168.0.2]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
To: linuxppc-dev@lists.linuxppc.org
From: "sean o'malley" <oses.mde.state.mi.us@lists.linuxppc.org>
Subject: Re: altivec
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I would love to work with Altivec, does anyone have any idea where to get
the hardware preferably cheap =)?


>>Well, if you do instruction-by-instruction emulation, the iteration count is
>>at most 16 (16 bytes in a vector). Furthermore, the overhead of a context
>>switch into privileged mode and back again is not negligible (at the very
>>least a pipeline flush and some saving/restoring of registers). Finally,
>>keeping the emulated vector registers somewhere in memory means that you will
>>quite often be limited by the availability of 'only' one load/store unit.
>
>That's true, I forgot about the 16 byte limit.  That will really make the
>overhead significant.  Kind of annoying to me (my typical vector length is
>over 900).  Maybe having two libraries is the way to go, then...
>
>>> I'm also wondering what has been done on this issue on the Intel side of
>>> the fence, since KNI and 3Dnow! are similar to Altivec in concept and, at
>>> least for 3Dnow!, implementation.
>>>
>>Similar? Please forgive my ranting, but AltiVec is feature-complete,
>>orthogonal, and implemented without compromises. MMX, 3DNow!, and ISSE have
>>none of the above three qualities. They were available sooner, but that's
>>about it.
>
>That's why I said "similar in concept" ... not execution.  And I said KNI
>(the PIII new instructions), not MMX, which is integers only.  (Also why I
>didn't mention Sun's VIS).
>_________________________________________________________________________
>                                __________
>##   ##   ###   #####   #####   \********/   #####    ###    ##### ######
>### ###  ## ##  ##  ## ##        \*/\/\*/    ##  ##  ## ##  ##     ##
>#######  ## ##  #####   ####       /\/\      #####   ## ##   ####  ####
>## # ## ####### ##  ##     ##      \**/      ##  ## #######     ## ##
>##   ## ##   ## ##  ## #####        \/       #####  ##   ## #####  ######
>_________________________________________________________________________
>### Mike DeSimone ### Hot-Wire@mail.utexas.edu ### ares.marsbase.mars ###

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
