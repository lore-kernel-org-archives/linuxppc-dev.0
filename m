Message-ID: <BFC0587634C3D111AACB00805FA766FA02C1C5FC@exchny12.ny.smb.com>
From: "Velasquez, Carlos" <carlos.velasquez@ssmb.com>
To: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>
Subject: kernel args for video mode..
Date: Thu, 1 Jul 1999 13:04:52 -0400 
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

How do I specify to the kernel (via bootX) what video card I have and the
modes I wish to use. I have an ixMicro 8 meg video card on my s900 mac
clone. Is the card known as tt128mb8 or is it     tt128m-b1? The latter is
what comes up on the twin turbo control panel on the MacOS side when I want
to tweak the bit depth or resolution.

So how do I specify it as kernel arguments? should I say:
video=tt128mb8 , vmode = XX , cmode =YY  (where XX and YY are the resolution
and bit depth respectively) or instead of commas, do I use semi-colons or
colons or what?

Also, do I uncheck the "Don't use Video driver" choice box? What happens if
I keep it checked ? Finally, how (if possible) do I change video and color
modes once I am already booted up? Can I do this on the fly?

Carlos

______________________________________________________________________
C.F. Velasquez
Asst. Vice President
Global Database and Technology Division
Salomon Smith Barney, Inc.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
