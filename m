Return-Path: <adobriyan@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.185])
	by ozlabs.org (Postfix) with ESMTP id 703CD67B64
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 10:32:08 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id k27so1122568nfc
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Aug 2006 17:32:06 -0700 (PDT)
Date: Fri, 11 Aug 2006 04:32:04 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 3/6] ehea: queue management
Message-ID: <20060811003204.GA6935@martell.zuzino.mipt.ru>
References: <44D99F38.8010306@de.ibm.com>
	<20060811000540.200CE67B6B@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060811000540.200CE67B6B@ozlabs.org>
Cc: Thomas Klein <tklein@de.ibm.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Raisch <raisch@de.ibm.com>, linuxppc-dev@ozlabs.org,
	Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > +static inline u32 map_swqe_size(u8 swqe_enc_size)
> > +{
> > +	return 128 << swqe_enc_size;
> > +}		      ^
> > +		      |
> > +static inline u32|map_rwqe_size(u8 rwqe_enc_size)
> > +{		      |
> > +	return 128 << rwqe_enc_size;
		      ^
> > +}		      |
>		      |
> Snap!  These are ide|tical...
		      |
No, they aren't. -----+

> Name the function after what it does, not after the functions you expect
> to call it.
