Date: Wed, 24 Apr 2002 07:47:33 -0700
From: Matt Porter <mporter@mvista.com>
To: andrew may <acmay@acmay.homeip.net>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Status on 405GP i2c driver
Message-ID: <20020424144733.GA11949@beef.az.mvista.com>
References: <20020422141601.B16319@ecam.san.rr.com> <20020423160548.A5009@home.com> <20020423182301.B19665@ecam.san.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020423182301.B19665@ecam.san.rr.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Apr 23, 2002 at 06:23:01PM -0700, andrew may wrote:
> On Tue, Apr 23, 2002 at 04:05:48PM -0700, Matt Porter wrote:
> >
> > On Mon, Apr 22, 2002 at 02:16:01PM -0700, andrew may wrote:
> > >
> > > It looks like this question was lasted asked around Jan/Feb, but
> > > I have not seen an update on the status recently.
> > >
> > > I have looked at the i2c-2.6.3 and I am reluctant to spend any
> > > time working on it since it needs to go through some formating
> > > changes to get rid of the C++ style comments. I don't want to
> > > deal with a merge issues of doing a style change unless I know
> > > it will go in.
> >
> > I pushed a modified version of Armin's latest updated patch in.
> > I'd love to see the C-- comments go away but I'm too lazy to play
> > with it beyond testing it on my platform.  If anybody sends patches
> > that clean up some more of the ugliness then I'll push them in.
>
> I have just started to use BK and this does provide an interesting
> test. I had started to merge the stuff in steps before you did your
> push. So here are some bk export's -tpatch of what I tried. I go
> lazy on the merge of the last Makefile and I thing I screwed it up.
>
> i2c-2.6.3.patch is a patch to bring this up to the i2c 2.6.3 level.
> i2c-2.6.3-405.patch adds the 405 files in 2.6.3
> i2c-2.6.3-armin.patch is Armin's patch without the file rename.
> i2c-merge1 & 2 should be just file mv's but I didn't do it too
> well.

It's not a good idea to merge the i2c-2.6.3 support into 2_4_devel.
The idea here is to make available a 4xx IIC driver that can be used
with the current i2c infrastructure in the 2.4 kernel and can be
changed in sync with any ocp changes that are made.

Regards,
--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
