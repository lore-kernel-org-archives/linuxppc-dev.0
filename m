Message-Id: <199906110543.HAA00297@piglet.cpu.lu>
Date: Fri, 11 Jun 1999 07:43:15 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Q: control is a C&T 65550?
To: drow@false.org
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <19990610165732.A3984@drow.res.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  10 Jun, this message from Daniel Jacobowitz echoed through cyberspace:
[snip'ed the details]
> 
> I intend to see what I can do about documenting the hardware cursor. 
> With all the excellent advice I've gotten, I expect it won't be too
> difficult.

One thing I have done to look at hoe this stuff is working is to put
the cursor under Macos and/or MacsBug at some precise location (top
left corner), and look at the data in the invisible last portion of
each scanline in VRAM. That should tell us how and in what format the
cursor bitmap needs to be drawn. Restricting the cursor movement to
horizontal movements, and looking at RaDaCal's registers, should tell
us where the horizontal position needs to be set.

Unfortunately, as to the registers that control the appearance of the
cursor (visible/not visible; its colors, etc...), I have no iddea where
exactly on RaDaCal they are, and how to identify them except by poking
at registers from a distance...

>> Obviously, all of the above information can be totally wrong ;-). If
>> there is any Apple engineer in the audience who knows better, please do
>> speak up!
> 
> Unfortunately, the Apple engineers in the audience aren't allowed to :(

What a shame! After all, the control hardware can be seen as a legacy
device, being surpassed by any and all current video chips... or might
Apple be hiding some really cool and powerful feature deep inside
control? I doubt it....

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
