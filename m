Date: Thu, 9 Sep 1999 09:25:45 -0500
From: Shaw Terwilliger <sterwill@io.nu>
To: Hugh Caley <hcaley@loomer.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Paul's devel branch on Lombard?
Message-ID: <19990909092545.C4200@io.nu>
References: <37D74322.B787B9FE@loomer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <37D74322.B787B9FE@loomer.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hugh Caley wrote:
> I have not had this problem with building Paul's 2.2.12 kernel.  I did not use
> a config file from a previous version, which sounds like the major difference
> between us.

The problem is not with the 2.2.12 kernel, but with the 2.3.16 branch in
his "devel" archive.  The "stable" branch is working like a champ for me.
I'm sorry if I didn't make that very clear in my message (I had just
spent three minutes writing down all those addresses).  :)

> Or:  which version of gcc are you using?  I'm using the gcc from the fsirl
> directory on dev.linuxppc.org, and the glibc and related files from the same
> site.

If it matters, I'm using GCC from the Debian Potato branch (which I have
installed).  I believe it's just EGCS 1.1.2 release; but it's building 
2.2.12 great, 2.3.16 just isn't building.  I guess it's possible there's
a 2.3 kernel problem with the compiler, although I don't see any problems
in the builds.

Has anyone built kernels (either 2.2 or 2.3) with GCC 2.95?  I'd build a new
compiler (even just to try) if I could build the newest one.  :P


-- 
Shaw Terwilliger (sterwill@io.nu)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
