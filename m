Date: Wed, 7 Nov 2001 17:30:53 -0300
From: Ricardo Scop <scop@vanet.com.br>
Reply-To: Ricardo Scop <scop@vanet.com.br>
Message-ID: <9729.011107@vanet.com.br>
To: linuxppc-embedded@lists.linuxppc.org
Cc: lehder@lists.linuxppc.org, mercio@lists.linuxppc.org
Subject: Linuxppc and MPC8255 routing performance
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I'm using Linux for PPC in a proprietary MPC8255-based hardware as an
embedded router system. I've been trying both Denx's kernel (as of
2001-07-23) and linuxppc_2_4 (last week's version), and everything
goes smoothly (thanks to all contributing guys...).

I have some performance numbers which I'd like to share and confront,
if possible. Core clock is 132 MHZ, and bus clock 33 Mhz.
Our hardware does not have a secondary (L2) cache (and I
wonder if it should...):

       - FTP transfer ratio through the router - 0.5 to 1.5 Mbytes/s;
       - # of packets per second (best case): 2000

All tests were accomplished using two fast ethernet interfaces.
Best performances where obtained with data cache disabled (yes, we
had to hack linuxppc_2_4 for that...).

Does that sound ok, compared to other 8260 systems? (8255 is almost
identical to 8260)

Any numbers or other feedbacks will be highly appreciated!

Best regards,

Scop, Ricardo                          mailto:scop@vanet.com.br


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
