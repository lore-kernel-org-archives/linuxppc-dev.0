Content-Type: text/plain;
  charset="iso-8859-1"
From: Ricardo Scop <scop@vanet.com.br>
To: Dan Malek <dan@embeddededge.com>,
	Ricardo Scop <scop@vanet.com.br>
Subject: Re: Linuxppc and MPC8255 routing performance
Date: Tue, 13 Nov 2001 15:38:47 +0300
Cc: linuxppc-embedded@lists.linuxppc.org
References: <D73A25AA6E54D511AD74009027B1110F04F5E1@ORION> <01111314034801.01064@scop.digitel.com.br> <3BF1522D.1010706@embeddededge.com>
In-Reply-To: <3BF1522D.1010706@embeddededge.com>
MIME-Version: 1.0
Message-Id: <01111315384703.01064@scop.digitel.com.br>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tuesday 13 November 2001 20:02, Dan Malek wrote:

> Ricardo Scop wrote:
> > Nevertheless, I'm aware that using local bus memory for I/O data flowing
> > between CPM and CPU may improve performance in some Linux applications,
> > so I would like to experiment with this.
>
> You don't need this as a solution to your performance troubles.  I have
> been experimenting with using this space for socket buffers, but unless
> you have something else on the bus consuming the cycles, I haven't seen
> any benefit.  It could be very useful for custom network applications,

Gee, sorry... I meant _network_ applications, indeed. And, thank you for your
advice.

As for our performance troubles, there have been some improvements; we were
making some mistakes regarding both FCC and PHY programming. After fixing
those, we're able to achieve more than 50 Mbits/s in a _real_ FTP transfer,
which is more than enough for our router application.  We are still
conducting more performance tests with netperf, and will publish the resuts
when available.

Thanks,

~Ricardo

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
