Date: Fri, 3 Oct 2003 08:07:47 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Jacky Lam <jackylam@astri.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Queston about Walnut
Message-ID: <20031003080747.A7933@home.com>
References: <20031002121733.A2E32C59E4@atlas.denx.de> <001101c3894c$38833ab0$2803050a@JackyLam> <3F7D3238.2090400@bluewin.ch> <00df01c38992$6d179b40$2803050a@JackyLam>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <00df01c38992$6d179b40$2803050a@JackyLam>; from jackylam@astri.org on Fri, Oct 03, 2003 at 05:40:46PM +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Oct 03, 2003 at 05:40:46PM +0800, Jacky Lam wrote:
>
> > the kernel you use - vanilla+ppc-patch - is based on linuxppc-2.4, which
> > is not appropriate for your system. [At least it was like that some time
> > ago. Tom, could you please comment.] Try using the linuxppc_2_4_devel
> > tree from Bitkeeper or from our FTP server (see http://www.denx.de).
>
>     I just tried. The result is the same. Using the original walnut_config,
> it hangs in mapin_ram().
>     If I use minimal config, it hangs in __sti().
>
>     Does anyone still working on Walnut platform and successfully boot up
> 2.4 kernel on that? If no, could someone remember what is the last known
> working toolchain and kernel on Walnut?

I noticed this about a week ago.  It is some kind of merge problem
between linux-2.4 and linuxppc-2.4.  linux-2.4 boot fine on walnut
for me.  I didn't have time to investigate but might take a look at
it again soon.

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
