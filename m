Message-ID: <3BF164B2.8080000@embeddededge.com>
Date: Tue, 13 Nov 2001 13:21:38 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Ricardo Scop <scop@vanet.com.br>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linuxppc and MPC8255 routing performance
References: <D73A25AA6E54D511AD74009027B1110F04F5E1@ORION> <01111314034801.01064@scop.digitel.com.br> <3BF1522D.1010706@embeddededge.com> <01111315384703.01064@scop.digitel.com.br>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ricardo Scop wrote:


> As for our performance troubles, there have been some improvements; we were
> making some mistakes regarding both FCC and PHY programming.


FYI, a major telecommuniation company paid for independent laboratory
certifcation of this driver (and Linux) under a variety of performance
and error conditions.  After a couple of iterations, it passed the
certification testing and I believe all of the modifications are in
this driver (at least it was my intention to ensure they are public).
I don't remember which PHY was used for the testing, but please don't
attack this as a "can't possibly work" problem and start hacking it up.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
