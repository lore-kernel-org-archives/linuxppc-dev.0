Subject: Re: parallel I/O ports & opend darin pins on MPC8xx
From: Craig Hollabaugh <craig@hollabaugh.com>
To: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <FCEAKDJJAPHPLJFINDAJOEFEDEAA.Stephan.Linke@epygi.de>
References: <FCEAKDJJAPHPLJFINDAJOEFEDEAA.Stephan.Linke@epygi.de>
Content-Type: text/plain
Date: 08 Jul 2003 09:49:37 -0600
Message-Id: <1057679377.870.18.camel@gibson>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 2003-07-08 at 09:31, Stephan Linke wrote:
> on one of our boards we are using one of the I/O pins in open drain mode. This leads to some problems in combination with other
> drivers that write to the ports data register. Since they can not detect the current output value of the open drain pin. They only
> see the status of the I/O pin no matter who forces the value the CPM or another device connected to the open drain pin. After
> writing back the value read from the I/O data register this value is forced by CPM which is normaly wrong.

Stephan,

What you are explaining, I beleive, is the reason why developers use
open drain in the first place. Multiple devices connected to control a
single signal giving bidirectional data flow.

>
> Did anyone run into that problem in the past? What was your solution? Any thing else but NOT using open drain pins?

Have you grepped the kernel source to find the other drivers affecting
that specific port control register? What did you look for and what did
you find?

Craig



>
--
------------------------------------------------------------
Dr. Craig Hollabaugh, craig@hollabaugh.com
Author of Embedded Linux: Hardware, Software and Interfacing
www.embeddedlinuxinterfacing.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
