Subject: Re: Why ack interrupt before calling handler?
From: Kenneth Johansson <kenneth.johansson@etx.ericsson.se>
To: Kent Borg <kentborg@borg.org>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <20030611083953.A26856@borg.org>
References: <20030606142939.B15725@borg.org>
	<1055327622.26152.70.camel@spawn>  <20030611083953.A26856@borg.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: 11 Jun 2003 14:58:32 +0200
Message-Id: <1055336312.26152.104.camel@spawn>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 2003-06-11 at 14:39, Kent Borg wrote:
> On Wed, Jun 11, 2003 at 12:33:42PM +0200, Kenneth Johansson wrote:

> Finally the interrupt end gets called, which acks and enables the
> interrupt.  This ack actually does something for me.
>

Hopefully this ack only happens if the interrupt is level triggered
otherwise you have a problem.

> I am thinking that the general purpose PPC code does the early
> ack for edge-triggered circumstances.  For latched level-triggered
> cases there is no harm in the extra early ack.

Thats right.

--
Kenneth Johansson
Ericsson AB                       Tel: +46 8 719 70 20
Tellusborgsvägen  90              Fax: +46 8 719 29 45
126 25 Stockholm                  ken@switchboard.ericsson.se


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
