Message-ID: <002401c1e679$7e69f8b0$1a11efcb@industrialDiv.hanasys.co.kr>
Reply-To: "Sangmoon Kim" <dogoil@etinsys.com>
From: "Sangmoon Kim" <dogoil@etinsys.com>
To: <linuxppc-embedded@lists.linuxppc.org>,
	"Dr. Craig Hollabaugh" <craig@hollabaugh.com>
References: <3.0.3.32.20020417095725.006a2034@spudcentral.com>
Subject: Re: Cross compiling glibc-2.2.3
Date: Thu, 18 Apr 2002 10:36:39 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, Dr. Craig Hollabaugh,

> >3. Edit the sysdeps/powerpc/Makefile
> >#ifeq ($(subdir),gmon)
> >#libm-support += fenv_const fe_nomask
> >#endif
>
> Kim,
>
> What does this step actually do?
>

I just referenced the denx patch. So I don't have the exact knowledge obout it. I guess the step is for omitting floating point because MPC860 doesn;t support it.I think supporting floating in kernel by floating-point interrupt,
and compile glibc without -msoft-float or -D_SOFT_FLOAT is better.But the guys in this list doesn't seam to recommand it.

> Also, should that be math above instead gmon?
>
> #ifeq ($(subdir),math)
> #libm-support += fenv_const fe_nomask
> #endif
>
That was my mistake. I meant...
#ifeq ($(subdir),math)
#libm-support += fenv_const fe_nomask
#endif


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
