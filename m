From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
	<linuxppc-dev@lists.linuxppc.org>, <debian-powerpc@lists.debian.org>
Subject: Re: Success! (was Re: External Monitor under Pismo)
Date: Sat, 5 May 2001 03:03:18 +0200
Message-Id: <20010505010318.5183@mailhost.mipsys.com>
In-Reply-To: 
 <Pine.LNX.4.30.0105042247590.3732-100000@opal.biophys.uni-duesseldorf.de>
References: 
 <Pine.LNX.4.30.0105042247590.3732-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> Yep. The same is true for atyfb (yes, I should add mirrorring/dualhead
>support
>> for the Mobility in my Vaio :-).
>
>Please do - I tried Ben's mirror utility on the Lombard but no success.
>And I still have no aty docs to look up the details in.

Well, if you do that, it may be interesting to impement the same
ioctls I have in my aty128fb version (I'll send it to you later
if you don't want to rsync down my entire tree).

I beleive you can do something very similar by just toggling the
CRT & LCD enable bits on the first CRT. No need for CRTC 2 for
simple mirroring. "Smart" mirroring (with higher refresh rate) would
require use of CRTC2 however.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
