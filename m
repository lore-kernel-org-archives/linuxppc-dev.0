Date: Mon, 23 Oct 2000 08:40:20 -0700 (PDT)
From: William Blew <wblew@home.com>
To: linuxppc-dev@lists.linuxppc.org
cc: Henning Löser <henning.loeser@physik.uni-marburg.de>
Subject: Re: gpm and XF401 (Re: ADB-Mouse)
In-Reply-To: <20001023150002.A3112@suse.de>
Message-ID: <Pine.LNX.4.10.10010230837370.11593-100000@apollo.kulian.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 23 Oct 2000, Olaf Hering wrote:

> You mean you mark some text at console with gpm and all you get in the
> selected area is garbage, even with a non psaux device?
> I tried it here on a chrp machine and got the same effect, could be a
> framebuffer bug. Anyone else with that problem?

Perhaps the hardware cursor? I have been experiencing hashed text problems
under the hardware cursor. I am using a fairly new pmac-stable 2.2. kernel
with my beige G3's builtin 3D rage pro (atyfb.c)

Specifically after an exit of the latest SDL library's console driver, the
text under the cursor is hashed, as is the width of the cursor (about 6-8
chars, not 1 char).

A "reset" command on the console fixes things, but nonetheless, it seems
to be similar, superficially.
--
William Blew, wblew@home.com
Gamer by Choice, Geek by Birth


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
