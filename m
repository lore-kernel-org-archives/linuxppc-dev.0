To: rekha gvv <rekhagvvc@yahoo.co.in>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: IMMR for fads mpc860 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 17 Oct 2002 03:04:42 PDT."
             <20021017100442.71539.qmail@web8005.mail.in.yahoo.com>
Date: Thu, 17 Oct 2002 12:41:04 +0200
Message-Id: <20021017104109.470F1FAA7@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20021017100442.71539.qmail@web8005.mail.in.yahoo.com> you wrote:
>
> I would like to know what is the physical address of
> Internal memory mapped register for the fads mpc860
> board ..

As the name says, the IMMR is a _register_ and  as  such  it  has  no
address, neither a phyical or a virtual one. The IMMR contains (among
some  other  bits) the physical address of the internal memory of the
MPC8xx. We do not know which value you load into  this  register  (or
how you initialize your CPU), so which sort of answer do you expect?

> and please verify if the values of the registers are
> correct in the file

These are no register values, but just some  #define'd  constants.  I
see no problems here.


Ummm... what is your real problem?

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
core error - bus dumped

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
