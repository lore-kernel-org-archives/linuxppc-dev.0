Message-Id: <v04003a00b4a42e0945bb@[216.81.27.54]>
In-Reply-To: <v04011700b4a419989df1@[129.116.196.236]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 13 Jan 2000 19:48:39 -0600
To: Greg Allen <gallen@arlut.utexas.edu>, linuxppc-dev@lists.linuxppc.org
From: Tony Mantler <eek@escape.ca>
Subject: Re: CodeWarrior objects -> LinuxPPC
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 6:32 PM -0600 1/13/00, Greg Allen wrote:
>Is it possible compile C source in CodeWarrior and create an object (or
>library) that can be used under LinuxPPC?
>
>For example, you should be able to take a really simple program, like:
>
>#include <stdio.h>
>void goo(float f)
>{ printf("goo: f = %g\n", f); }
>
>make an object in CW, copy to LinuxPPC, link it with gcc into some app that
>can call goo.
>
>(Why? CW has an AltiVec compiler, Linux currently has none.)
>
>I notice that a CW "Shared Library" is recognized by /usr/bin/file as
>"header for PowerPC PEF executable", but objdump will have nothing to do
>with it.
>
>My initial guess is "not yet".  Has anyone else ever tried this?
>
>I guess there's no reason that objcopy couldn't be extended to handle this
>(assuming CodeWarrior's object/lib file formats are public info).

Last I checked, all the MacOS runtime architectures are well documented by
Apple, right back to the original 68k Segment Manager. Try
<http://developer.apple.com/techpubs/mac/runtimehtml/RTArch-89.html> for a
start.

You might check the appropriate ABIs though, to see if there's any
inconsitancies between how codewarrior generates it's code for MacOS, and
what linux expects the code to look like.


But before you do all that, check to see if Altivec register saving is
implemented in the kernel yet. There was a discussion a while back on how
to do it best, but I didn't hear if any code came out of it.

(I don't have a G4, so I'm certainly not going to write it... Donations are
welcome though) 8)


Cheers - Tony :)


--
Tony Mantler         Renaissance Nerd Extraordinaire         eek@escape.ca
Winnipeg, Manitoba, Canada                       http://www.escape.ca/~eek


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
