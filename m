In-Reply-To: <1079025268.29565.51.camel@chuck.arlut.utexas.edu>
References: <1078945499.3748.4.camel@veena.timesys> <1079019785.29565.36.camel@chuck.arlut.utexas.edu> <405090F3.1000900@embeddededge.com> <1079025268.29565.51.camel@chuck.arlut.utexas.edu>
Mime-Version: 1.0 (Apple Message framework v612)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <C27D4FB6-73AE-11D8-A4B4-000393DBC2E8@motorola.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>,
	Jason McMullan <jason.mcmullan@timesys.com>,
	Dan Malek <dan@embeddededge.com>
From: Kumar Gala <kumar.gala@motorola.com>
Subject: Re: MPC8560ADS issues
Date: Thu, 11 Mar 2004 16:52:23 -0600
To: "Matthew S. McClintock" <mattsm@arlut.utexas.edu>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm confused the gianfar driver is for the MPC8540 FEC.  I believe the
initial question was regarding the FCC (on CPM / MPC8560).

As to why your having poor performance on the MPC8540 FEC, that seems
odd -- possibly some issue with the Intel PHY.  I do not believe we are
seeing anything similar on the ADS.

- kumar

On Mar 11, 2004, at 11:14 AM, Matthew S. McClintock wrote:

>
> On Thu, 2004-03-11 at 10:16, Dan Malek wrote:
>
>> Do you keep up to date with the linuxppc trees?  Some of us have been
>> pushing lots of CPM updates lately.  We recently updated all of the
>> common code for 82xx and 85xx.  If this doesn't work there must be
>> some I/O or board configuration that is amiss.
>
> I'm running the latest linuxppc-2.4 branch. I'm not using the
> MPC8540ADS
> board, the board I am using has an Intel LXT971A PHY attached to the
> FCC. I've added support for that physical layer to
> drivers/gianfar_phys.c. I'm guessing something is wrong with that code
> that is making it go so slow, but I have been unable to pinpoint what
> might be wrong.
>
> I've noticed that the interrupts for the FCC come in at a very very
> slow
> pace, that is the only thing I have really noticed that is odd. I've
> also tried changing the priority of the interrupt via the IIVPR
> register
> for the FCC with no results. I can't think of anything else I can
> investigate, unless you have any ideas?
>
> Thanks,
> Matthew
>
> --
> Matthew S. McClintock <mattsm@arlut.utexas.edu>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
