Message-ID: <001501c389cc$3d1277a0$0202a8c0@homevl9biy3v7e>
From: "Jacky Lam" <jackylam@astri.org>
To: <linuxppc-embedded@lists.linuxppc.org>
References: <20031002121733.A2E32C59E4@atlas.denx.de> <001101c3894c$38833ab0$2803050a@JackyLam> <3F7D3238.2090400@bluewin.ch> <00df01c38992$6d179b40$2803050a@JackyLam> <20031003080747.A7933@home.com>
Subject: Re: Queston about Walnut
Date: Sat, 4 Oct 2003 00:34:37 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


----- Original Message -----
From: "Matt Porter" <mporter@kernel.crashing.org>
To: "Jacky Lam" <jackylam@astri.org>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sent: Friday, October 03, 2003 11:07 PM
Subject: Re: Queston about Walnut


>
> On Fri, Oct 03, 2003 at 05:40:46PM +0800, Jacky Lam wrote:
> >
> > > the kernel you use - vanilla+ppc-patch - is based on linuxppc-2.4,
which
> > > is not appropriate for your system. [At least it was like that some
time
> > > ago. Tom, could you please comment.] Try using the linuxppc_2_4_devel
> > > tree from Bitkeeper or from our FTP server (see http://www.denx.de).
> >
> >     I just tried. The result is the same. Using the original
walnut_config,
> > it hangs in mapin_ram().
> >     If I use minimal config, it hangs in __sti().
> >
> >     Does anyone still working on Walnut platform and successfully boot
up
> > 2.4 kernel on that? If no, could someone remember what is the last known
> > working toolchain and kernel on Walnut?
>
> I noticed this about a week ago.  It is some kind of merge problem
> between linux-2.4 and linuxppc-2.4.  linux-2.4 boot fine on walnut
> for me.  I didn't have time to investigate but might take a look at
> it again soon.

    Really? That's so great! Do you have any idea about this? Maybe I can
try to investigate as well. Also, do you remember what is the version just
before this merge problem occurs? Thanks.

Best Regards,
Jacky


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
