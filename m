Message-ID: <3F3B2E3D.8040607@devcom.cz>
Date: Thu, 14 Aug 2003 08:37:49 +0200
From: Jan Damborsky <jan.damborsky@devcom.cz>
MIME-Version: 1.0
To: Iain Barker <ibarker@aastra.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Ethernets on SCC2 and SCC3 on mpc8xx
References: <F924CEFBBF62D611A0C600D0B76ED0375C4207@cvxmail.ana.aastra.com>
In-Reply-To: <F924CEFBBF62D611A0C600D0B76ED0375C4207@cvxmail.ana.aastra.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>The FCC driver on 8260 supports up to 3 Ethernet ports. I don't think there
>is any similar on the SCC used on 8xx (just one SCC can run Ethernet in the
>standard driver, you choose which SCC) but if you are using 8xx with FEC you
>can use one SCC and FEC to give two Ethernet ports on an 8xx.
>
But we use MPC823e which has not FEC (unfortunately). May be in future ?
So I have only SCCs for Etherenet. But driver modifying
should not be very difficult (as Wolfgang Denk wrote).

                                Thank you,
                                          HANYS


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
