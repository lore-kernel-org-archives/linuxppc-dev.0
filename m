Subject: Re: conflicts between SMC1 and UTOPIA on MPC850SAR
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: 04 Dec 2002 13:05:58 +0000
Message-Id: <1039007158.16916.50.camel@zambia>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I called it the FADS_BUG because I first saw it on the FADS board and I
assumed that the problem was particular to the FADS board.  Since then I
have also seen the problem on our bespoke board.  However, I found that
changing RCCR[DRQP] from 01b - which Motorola recommends - to 10b fixed
the problem.

I think I found that the problem was worst when using internal
connection tables and when receiving and transmitting high data rates.

I've asked Motorola about this but I've never got an answer from them.

Alex

On Wed, 2002-12-04 at 11:57, Jörg Huwig wrote:
>
> Hi,
>
> I'm using the mpc860sar-1.6 utopia driver with a MPC850SAR CPU.
> Generally the driver seems to work but I have the following problem: The
> reception of atm frames causes the SMC1 (used for console output) to think
> that it's receiving characters.
> I have already given IDMA requests the lowest priority (#define FADS_BUG),
> but it does not change anything.
>
> Has anybody experience with this problem?
>
> Thanks,
>
> Joerg
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
