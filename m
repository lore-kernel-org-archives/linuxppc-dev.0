Subject: Re: Cross compiling glibc-2.2.3
In-Reply-To: <002401c1e679$7e69f8b0$1a11efcb@industrialDiv.hanasys.co.kr> from
 Sangmoon Kim at "Apr 18, 2002 10:36:39 am"
To: Sangmoon Kim <dogoil@etinsys.com>
Date: Wed, 17 Apr 2002 19:48:06 -0600 (MDT)
Cc: linuxppc-embedded@lists.linuxppc.org,
	"Dr. Craig Hollabaugh" <craig@hollabaugh.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20020418014806.BD5E127C5B@chuy.ouraynet.com>
From: craig@hollabaugh.com (Dr. Craig Hollabaugh)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I just referenced the denx patch. So I don't have the exact knowledge obout it. I guess the step is for omitting floating point because MPC860 doesn;t support it.I think supporting floating in kernel by floating-point interrupt,
> and compile glibc without -msoft-float or -D_SOFT_FLOAT is better.But the guys in this list doesn't seam to recommand it.

No, I asked about this last week and Wolfgang said turn off FP emulation in the kernel and compile
libs and apps with soft-float.

see thread, http://lists.linuxppc.org/linuxppc-embedded/200204/msg00174.html


>
> > Also, should that be math above instead gmon?
> >
> > #ifeq ($(subdir),math)
> > #libm-support += fenv_const fe_nomask
> > #endif
> >
> That was my mistake. I meant...
> #ifeq ($(subdir),math)
> #libm-support += fenv_const fe_nomask
> #endif


OK

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
