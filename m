Date: Tue, 2 Dec 2003 19:43:02 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Brian Kuschak <bkuschak@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 440gx ethernet lockup
Message-ID: <20031203034302.GA27648@gate.ebshome.net>
References: <20031121071157.GA7078@gate.ebshome.net> <20031202210118.39431.qmail@web40901.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031202210118.39431.qmail@web40901.mail.yahoo.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Dec 02, 2003 at 01:01:18PM -0800, Brian Kuschak wrote:
>
> I found the problem.  Our SEEPROM was misconfigured to
> set the MAL clock to PLB/4.  This resulted in a MAL
> clock of 41MHz, apparently too slow...  After changing
> the MAL clock to PLB/1, the system ran for days
> without any problems.  Unfortunately I couldn't find
> any IBM docs which specify requirements for the MAL
> clock, and IBM still hasn't responded.
>

Well, I just checked 440GX manual and it does states that minimum MAL
clock is 45MHz (see CPR0_MALD register definition).

Eugene.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
