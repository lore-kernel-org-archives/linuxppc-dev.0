To: "Stephan Linke" <Stephan.Linke@epygi.de>
Cc: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: parallel I/O ports & opend darin pins on MPC8xx 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 08 Jul 2003 17:31:35 +0200."
             <FCEAKDJJAPHPLJFINDAJOEFEDEAA.Stephan.Linke@epygi.de>
Date: Tue, 08 Jul 2003 23:36:57 +0200
Message-Id: <20030708213702.030BEC6D82@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Stephan,

in message <FCEAKDJJAPHPLJFINDAJOEFEDEAA.Stephan.Linke@epygi.de> you wrote:
>
> on one of our boards we are using one of the I/O pins in open drain mode. This leads to some problems in combination with other

Please don't use such long lines, they are hard to read.

> drivers that write to the ports data register. Since they can not detect the current output value of the open drain pin. They only
> see the status of the I/O pin no matter who forces the value the CPM or another device connected to the open drain pin. After
> writing back the value read from the I/O data register this value is forced by CPM which is normaly wrong.

This is a feature. It allows you to detect the the state of  the  pin
which can be pretty useful.

> Did anyone run into that problem in the past? What was your solution? Any thing else but NOT using open drain pins?

It is _not_ a problem, it is a feature, and a useful one.

Solution? What is so difficult about latching your output value in  a
variable?


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
It is practically impossible to teach good programming style to  stu-
dents that have had prior exposure to BASIC: as potential programmers
they are mentally mutilated beyond hope of regeneration.   - Dijkstra

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
