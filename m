Subject: Re: EP405 linker error.
From: Kenneth Johansson <kenneth.johansson@etx.ericsson.se>
To: Toni Van Remortel <t.vanremortel@ha.be>
Cc: Eugene Surovegin <ebs@ebshome.net>,
	"linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <20030331113552.58ceec69.t.vanremortel@ha.be>
References: <20030331111051.74af0790.t.vanremortel@ha.be>
	<5.1.0.14.2.20030331011506.02cd4d78@mail.ebshome.net>
	<20030331113552.58ceec69.t.vanremortel@ha.be>
Content-Type: text/plain; charset=ISO-8859-1
Date: 31 Mar 2003 14:44:24 +0200
Message-Id: <1049114664.31297.208.camel@spawn>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 2003-03-31 at 11:35, Toni Van Remortel wrote:
>
> I didn't know that there was an ATI RADEON on this EP405 ;-) How come that it seeks for that? Wrong .config?
>

The check is done in runtime not when you compile and you can have the
card  on any system with a pci bus.

For now just remove the line and everything will be OK since you did not
have the card.

--
Kenneth Johansson
Ericsson AB                       Tel: +46 8 719 70 20
Tellusborgsvägen  90              Fax: +46 8 719 29 45
126 25 Stockholm                  ken@switchboard.ericsson.se


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
