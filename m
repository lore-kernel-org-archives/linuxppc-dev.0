Message-ID: <3AEEF8F3.8EDB36A7@mvista.com>
Date: Tue, 01 May 2001 10:57:07 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: ashish anand <ashisha@india.infogain.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: sandpoint spurious interrupt problem.
References: <12D7808A.BAC6DDED@india.infogain.com> <3AEEF8BC.FE7CFAC@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


BTW, the linuxppc_2_5 should "just work" for the 750 if you have the switch
settings correct.

Mark
--

"Mark A. Greer" wrote:

> Did you start with the sandpoint port that is a part of linuxppc_2_5?  If not,
> you should.
> If so, double-check your switch settings.
>
> Mark
> --
>
> ashish anand wrote:
>
> > I am working towards porting linux on sandpoint with mpc750
> > I face the problem of continious spurious interrupts on booting
> > as per the base code SIOint is cascaded to EPIC in level triggered
> > mode , problem vanishes when i change it to edge triggered mode
> > also recall written in some intel document that external interrupts from
> > 8259 or equivalent pic's should be cascaded to APIC in edge triggered
> > mode only
> > why this requirement for cascading the interrupts from 8259 or other pic's
> > to APIC/EPIC
> > any comment on this will help me much
> >


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
