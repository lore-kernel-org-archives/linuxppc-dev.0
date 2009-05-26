Return-Path: <ben@fluff.org.uk>
Received: from kira.home.fluff.org (aeryn.fluff.org.uk [87.194.8.8])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CD7DEDE03B
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 07:34:35 +1000 (EST)
Date: Tue, 26 May 2009 22:33:51 +0100
From: Ben Dooks <ben-linux@fluff.org>
To: Esben Haabendal <esbenhaabendal@gmail.com>
Subject: Re: [PATCH v2] i2c-mpc: generate START condition after STOP caused
	by read i2c_msg
Message-ID: <20090526213351.GG23114@fluff.org.uk>
References: <4A124202.4010201@doredevelopment.dk>
	<d2b9ea600905260430i72290901p9266de4cade049c1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d2b9ea600905260430i72290901p9266de4cade049c1@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org,
	Esben Haabendal <eha@doredevelopment.dk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 26, 2009 at 01:30:21PM +0200, Esben Haabendal wrote:
> On Tue, May 19, 2009 at 7:22 AM, Esben Haabendal <eha@doredevelopment.dk> wrote:
> > This fixes MAL (arbitration lost) bug caused by illegal use of
> > RSTA (repeated START) after STOP condition generated after last byte
> > of reads. With this patch, it is possible to do an i2c_transfer() with
> > additional i2c_msg's following the I2C_M_RD messages.
> >
> > It still needs to be resolved if it is possible to fix this issue
> > by removing the STOP condition after reads in a robust way.
> >
> > Signed-off-by: Esben Haabendal <eha@doredevelopment.dk>
> > ---
> > ?drivers/i2c/busses/i2c-mpc.c | ? ?9 +++++++--
> > ?1 files changed, 7 insertions(+), 2 deletions(-)
> 
> Any blockers to get this accepted?

It would be nice to get an ack from someone who can actually test
the driver before getting this merged.
 
> /Esben
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
