Date: Fri, 5 Nov 1999 21:22:47 -0700
From: Kevin Buettner <kev@primenet.com>
Message-Id: <991106042247.ZM15830@saguaro.lan>
In-Reply-To: Dan Malek <dmalek@jlc.net>
        "Re: gdbserver ?" (Nov  5, 10:10pm)
References: <199911051732.SAA29775@denx.local.net>  <38239C25.D0392585@jlc.net>
To: Dan Malek <dmalek@jlc.net>, Wolfgang Denk <wd@denx.de>
Subject: Re: gdbserver ?
Cc: shebs@cygnus.com, linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Nov 5, 10:10pm, Dan Malek wrote:

> > has anybody ever tried to build gdbserver for a PPC target?
> 
> I placed a tar image of just the gdbserver sub-directory on ppc.kernel.org.
> It is in the embedded directory.  The binary is built for an R4 system.
> The code is from a 4.17 version of gdb.  I believe all of the changes
> are in low-linux.c.
> 
> It works with the latest kernels, and I also built an out-of-the-box
> version of Cygnus Insight on a LinuxPPC 1999 host that worked fine with
> it.
> 
> I hope someone that knows more about this than I can make these changes
> look prettier and ensure it finds its way into a standard release.

Dan,

Send me your patches and I'll see what I can do.  If you don't have
a copyright assignment on file with the FSF, you'll need to fill one
out before I can incorporate your changes though.  (Yes, I know it's
a hassle.)

Thanks,

Kevin

-- 
Kevin Buettner
kev@primenet.com, kevinb@cygnus.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
