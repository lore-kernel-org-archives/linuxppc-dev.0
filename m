Message-ID: <6F8DFFA2C996D711945800065BFC9E4A0397542A@il02exm11>
From: Silverton Aron-C1710C <Aron.J.Silverton@motorola.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MPC7410
Date: Fri, 12 Dec 2003 14:54:46 -0600
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I wrote:
>
> Is anybody out there working with the MPC7410. It is similar to the
> MPC7450.
>
> I am wondering what, if any, --with-cpu or -mcpu switch is appropriate
> for this CPU.

Sorry to follow-up on my own post, but I discovered some information.

I contacted somebody in our semiconductor group and he was able to tell me
that the 7400, which does have a gcc command line switch, and the 7410 are
essentially the same from a register point of view.  The 7410 has an
additional register that allows one to use the L2 cache, which is larger
than that on the 7400, as SRAM.  Or something like that anyway.  The
--with-cpu=7400 or -mcpu=7400 is the best option to use with the 7410.

For those interested, there is plenty of information available here:

http://e-www.motorola.com/webapp/sps/site/prod_summary.jsp?code=MPC7410&node
Id=03C1TR046708718653

Regards,

Aron

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
