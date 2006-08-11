Return-Path: <mikey@ozlabs.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
From: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 3/6] ehea: queue management 
In-reply-to: <20060811003204.GA6935@martell.zuzino.mipt.ru> 
References: <44D99F38.8010306@de.ibm.com>
	<20060811000540.200CE67B6B@ozlabs.org>
	<20060811003204.GA6935@martell.zuzino.mipt.ru>
Date: Fri, 11 Aug 2006 10:46:01 +1000
Sender: mikey@ozlabs.org
Message-Id: <20060811004602.23EB467B64@ozlabs.org>
Cc: Thomas Klein <tklein@de.ibm.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Raisch <raisch@de.ibm.com>, linuxppc-dev@ozlabs.org,
	Marcus Eder <meder@de.ibm.com>
Reply-To: Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > > +static inline u32 map_swqe_size(u8 swqe_enc_size)
> > > +{
> > > +	return 128 << swqe_enc_size;
> > > +}		      ^
> > > +		      |
> > > +static inline u32|map_rwqe_size(u8 rwqe_enc_size)
> > > +{		      |
> > > +	return 128 << rwqe_enc_size;
> 		      ^
> > > +}		      |
> >		      |
> > Snap!  These are ide|tical...
> 		      |
> No, they aren't. -----+

Functionally identical.

Mikey
