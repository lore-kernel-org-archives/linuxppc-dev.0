Message-ID: <37F0E904.2E586BA8@execpc.com>
Date: Tue, 28 Sep 1999 11:12:52 -0500
From: Joseph Garcia <jpgarcia@execpc.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Keyboard problewm
References: <19990928154833.028330@mailhost.mipsys.com>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
> Basically, the problem if whatever you define in your userland keymaps
> (console keymap or X keymap), the alt-shift-key combos never work. That's

this may be unrelated, but i've noticed that with XF3.3.5, the META key, which
is ALT on PCs and command/apple key on macs, has been remapped to the option,
which on my powerbook is also labeled alt.  so to switch from console to X, i
use command, X to console - option.  i don't mind it much.  its just annoying to
find out what programs use X's keymap (option) and  not the other (kernel's?)
keymap (command) when i think they should be the same thing, or at least
mirroring.

$.02

-- 
Joseph P. Garcia      jpgarcia@execpc.com      jpgarcia@lidar.ssec.wisc.edu
CS Undergraduate                      Student Employee - Systems Programmer
University of Wisconsin - Madison                            UW Lidar Group

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
