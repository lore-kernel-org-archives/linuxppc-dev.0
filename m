Date: Mon, 20 Sep 1999 12:24:35 -0700 (MST)
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-user@lists.linuxppc.org,
        yellowdog-general@lists.yellowdoglinux.com,
        linuxppc-dev@lists.linuxppc.org, mklinux-setup@public.lists.apple.com
Subject: XFree86 3.3.5
In-Reply-To: <19990630224756.A16481@jaim.dtek.chalmers.se>
Message-ID: <Pine.LNX.4.10.9909031141370.8429-100000@opus.bloom.county>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'd like to announce some test RPMS for of XFree86-3.3.5 that will work
under LinuxPPC 1999, YDL CS 1.x, and MkLinux pre-R1.  These RPMS include
the following:

Anything that's been fixed in 3.3.5 over previous versions
USB keymap problems (Backspace/delete)
USB mouse stuff cleanup (mouseconfig sets BusMouse or IMPS/2)
Cleaned up adb keymaps/keycodes/etc (Kostas Gewrgiou <gewrgiou@imbc.gr>)
Updated Xautoconfig to take advantage of said fixes
Updated Xconfigurator to take advantage of said fixes
JDK fixes for XF68_FBDev

Note, with the JDK fixes there is a 99% chance you will need to
reconfigure X (old "Depth 32" is now 24, 16 is now 15 or 16, depending on
weather it's really 15bit or 16bit.).  If you have any problems with this
release, please make sure you reconfigured your /etc/X11/XF86Config file
with one of the provided tools.  The old ones will not work properly.

It's all available from ftp://devel.linuxppc.org/users/trini/XFree86-3.3.5
For Xautoconfig, Xconfigurator and mouseconfig there are versions for
uusbd (2.2.6) and normal USB stacks (2.2.10 from Paul M's site, 2.3.x,
samba's kernel tree, etc).

This fixes a good number of little bugs with USB (backspace in NS), and
makes things a bit cleaner (you can configure USB for the new kernels),
unless you're happy with your current setup, updating is sugjested, as
there are many security fixes from 3.3.3.1 or 3.3.4 to 3.3.5.

---
Tom Rini (TR1265)
http://gate.crashing.org/~trini/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
