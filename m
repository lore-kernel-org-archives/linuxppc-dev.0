Message-Id: <v03130302b40ca89cb4be@[192.168.1.1]>
In-Reply-To: <37E6E543.EB733942@usa.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 20 Sep 1999 22:23:39 -0500
To: happyoscar42@usa.net
From: "David D. Kilzer" <ddkilzer@computer.org>
Subject: Re: 2.3.whatever and hfs
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


David Riley <happyoscar42@usa.net> wrote:
>The current vger 2.3 kernel (whatever it is, maybe 2.3.18) compiles
>without a hitch, except at the end when it's linking it all up and it
>dies with an unresolved symbol "update_vm_chache" in hfs.o.  I'd like to
>be able to use hfs with my 2.3 kernel; is there a fix for this?

Yes.  Someone must rewrite the HFS code to use the new unified buffer code.
I think both minixfs and ext2fs have been rewritten, but HFS and other
'foreign' file systems have not been rewritten.

The short-term solution is not to include support for HFS in your kernel.

The long-term solution is to fix HFS to work with the new unified buffer
code.  Unfortunately, the HFS maintainer is busy and may not be able to fix
this until well into 2.4.

Personally, I think that, "if you break it, you fix it," but apparently
this doesn't always apply to kernel internals.

Dave


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
