To: David Ho <DavidHo@nanometrics.ca>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: patch for cpu/mpc8xx/cpu.c:get_tbclk 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 27 May 2004 15:07:34 EDT."
             <OFFF069FF9.720525F3-ON85256EA1.00688E39-85256EA1.0069104C@nanometrics.ca>
Date: Thu, 27 May 2004 23:48:56 +0200
Message-Id: <20040527214901.776EAC109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear David,

in message <OFFF069FF9.720525F3-ON85256EA1.00688E39-85256EA1.0069104C@nanometrics.ca> you wrote:
>
> The last if condition is wrong in this function.   The change is made
> against 0.4.8.  AFAIK, 1.0.2 still has the same problem.

Let me guess what your are talking about. This is the
linuxppc-embedded mailing list. Are you talking about Linux?

Or are you completely off topic here?

> And I wonder why it has to reverse engineer the oscclk when I pass the
> value as a define to come up with the gd->cpu_clk for the MPC866 family...
> It is a bit useless I think.

Then submit a patch which iomproves the situation.  But  please  send
this  to  the  proper  mailing  list  (u-boot-users),  and follow the
instructions in the README (section "Submitting Patches").

Thanks.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
No question is too silly to ask. Of course, some  questions  are  too
silly to to answer...  - L. Wall & R. L. Schwartz, _Programming Perl_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
