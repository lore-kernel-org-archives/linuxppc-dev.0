Date: Sat, 25 Sep 1999 13:57:23 -0700 (MST)
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-user@lists.linuxppc.org,
        yellowdog-general@lists.yellowdoglinux.com,
        linuxppc-dev@lists.linuxppc.org, mklinux-setup@public.lists.apple.com
Subject: XFree86-3.3.5-1.6.0b
In-Reply-To: <Pine.LNX.4.10.9909031141370.8429-100000@opus.bloom.county>
Message-ID: <Pine.LNX.4.10.9909251336400.8691-100000@opus.bloom.county>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello again all.

I've uploaded XFree86-3.3.5-1.6.0b rpms to
ftp://devel.linuxppc.org/users/trini/XFree86-3.3.5
If you installed 3.3.5-1.6.0a, and use FBDev, you only need to update that
particular RPM.  If you use Xpmac, nothing should have changed.  This
should fix most of the invalid depth/etc problems when trying to do >16.

Compiling w/ egcs 1.1.2-12f did not fix at least the main accel bug
(crash), so this is built vs 2.95.x as well.  More feedback/etc is
welcome.

---
Tom Rini (TR1265)
http://gate.crashing.org/~trini/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
