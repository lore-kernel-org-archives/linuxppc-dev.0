Message-ID: <3BF1522D.1010706@embeddededge.com>
Date: Tue, 13 Nov 2001 12:02:37 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Ricardo Scop <scop@vanet.com.br>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linuxppc and MPC8255 routing performance
References: <D73A25AA6E54D511AD74009027B1110F04F5E1@ORION> <01111314034801.01064@scop.digitel.com.br>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ricardo Scop wrote:


> Nevertheless, I'm aware that using local bus memory for I/O data flowing
> between CPM and CPU may improve performance in some Linux applications, so I
> would like to experiment with this.

You don't need this as a solution to your performance troubles.  I have
been experimenting with using this space for socket buffers, but unless
you have something else on the bus consuming the cycles, I haven't seen
any benefit.  It could be very useful for custom network applications,
but there isn't anything Linux will do.  Some systems just toss this space
into the general free memory pool, just remember you can't access it over
the 60x bus.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
