Message-ID: <3981C336.6C861F5E@mvista.com>
Date: Fri, 28 Jul 2000 10:30:30 -0700
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: Dan Malek <dan@netx4.com>
CC: Ralph Blach <rcblach@raleigh.ibm.com>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: error in assumptions in the handling of interrupts.
References: <398178CF.6AEAF91E@raleigh.ibm.com> <3981A326.39228806@embeddededge.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:
>
> Ralph Blach wrote:
>
> > This will NOT work because for Level interrupts, the ISR will cannot be
> > reset until
> > the interrupting source is cleared.
>
> It works for Level interrupts on the 8xx and 8260.......
>
> > The ack to reset the ISR for interrupt must go in the
> >
> > ppcxxx_aic_enable
>
> So, put it there.  All of these functions should be unique to
> the 405GP interrupt controller.  You are free to implement this
> as you wish.
>
>         -- Dan
>

I'll take care of the problem in the 405gp version of these functions, but there
are also 403 specific versions of the functions.  I've seen various people on this
mailing list posting about 4xx processors (other than 405), but I haven't figured
out if there is anyone who is at the center of 401 and/or 403 development and
haven't found the info in the various FAQs yet.  Is there any such person?

Thanks,

-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
