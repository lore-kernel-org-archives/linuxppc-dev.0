Date: Fri, 22 Sep 2000 16:25:51 -0400 (EDT)
From: Henry Worth <haworth@ncal.verio.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Linux keycodes and left cursor on Pismo
Message-ID: <Pine.SOL.4.10.10009221556010.17778-100000@ncal.verio.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Ddnzer <daenzerm@student.ethz.ch> wrote:

>After switching to Linux keycodes (and Debian's i386 us keymap), the left
>cursor key doesn't generate a keycode anymore. Interestingly, it works in
>X
>with Xkb, but not without.
>
>Anyone else sees this?
>

Check the dev and user archives, I think this has been discussed a
few times since the new input layer backport went in.

>
>Also, what is the key combination for the Magic Sysrq on a Pismo?
>

For xmon it's <cmd><Power>. I'm not sure the Linux SysReq facility
is supported for PPC, I've never seen it enabled in Ben's .config
files and there is no sign of it in the archives.

However, invoking xmon once X (at least Xpmac 10) is running
will result in a microscopic xmon text session replicated 4 times
across the screen (even if you switch back to a text VT first).

Henry


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
