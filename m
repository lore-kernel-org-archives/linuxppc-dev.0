Return-Path: <joern@wohnheim.fh-wedel.de>
Received: from wohnheim.fh-wedel.de (wohnheim.fh-wedel.de [213.39.233.138])
	by ozlabs.org (Postfix) with ESMTP id 1482767B73
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 19:38:08 +1000 (EST)
Date: Fri, 11 Aug 2006 11:21:32 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Thomas Klein <osstklei@de.ibm.com>
Subject: Re: [PATCH 3/6] ehea: queue management
Message-ID: <20060811092132.GA4137@wohnheim.fh-wedel.de>
References: <44D99F38.8010306@de.ibm.com>
	<20060811000540.200CE67B6B@ozlabs.org>
	<20060811003204.GA6935@martell.zuzino.mipt.ru>
	<20060811004602.23EB467B64@ozlabs.org> <44DC319A.10802@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <44DC319A.10802@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Michael Neuling <mikey@neuling.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Christoph Raisch <raisch@de.ibm.com>, linuxppc-dev@ozlabs.org,
	Marcus Eder <meder@de.ibm.com>, Alexey Dobriyan <adobriyan@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 11 August 2006 09:28:26 +0200, Thomas Klein wrote:
> Michael Neuling wrote:
> >>>>+static inline u32 map_swqe_size(u8 swqe_enc_size)
> >>>>+static inline u32|map_rwqe_size(u8 rwqe_enc_size)
> >  
> Agreed. Functions were replaced by a single map_wqe_size() function.

Just a general thing, try to avoid having two identifiers that are
near-100% identical.  As seen in this thread, they are _very_ easy to
confuse.

Ime, there are two methods to avoid this.  One is to make the
identifiers longer, something like "map_seek_wqe_size" and
"map_read_wqe_size".  The other is to make them shorter, just "s" and
"r" is less confusing than the above.

Which method works best depends on many things, including personal
taste.

Jörn

-- 
And spam is a useful source of entropy for /dev/random too!
-- Jasmine Strong
