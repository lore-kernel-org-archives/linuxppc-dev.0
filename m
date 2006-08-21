Return-Path: <joern@wohnheim.fh-wedel.de>
Received: from wohnheim.fh-wedel.de (wohnheim.fh-wedel.de [213.39.233.138])
	by ozlabs.org (Postfix) with ESMTP id 9C99D67BB4
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 23:18:38 +1000 (EST)
Date: Mon, 21 Aug 2006 15:18:31 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: Re: [2.6.19 PATCH 1/7] ehea: interface to network stack
Message-ID: <20060821131831.GA31094@wohnheim.fh-wedel.de>
References: <200608181329.02042.ossthema@de.ibm.com>
	<20060818144429.GF5201@martell.zuzino.mipt.ru>
	<200608211423.54250.ossthema@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <200608211423.54250.ossthema@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
	Thomas Klein <osstklei@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>, Marcus Eder <meder@de.ibm.com>,
	Alexey Dobriyan <adobriyan@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 21 August 2006 14:23:53 +0200, Jan-Bernd Themann wrote:
> 
> Is it valid (common in the kernel environment) to treat NULL as 0 after a memset
> and thus to forget about initialization?

Yes.  According to C99, "An implementation might conveivably have
codes for floating zero and/or null pointer other than all bits zero."
But as long as you don't use floating point (you shouldn't) and don't
redefine NULL to something other than (void*)0, this is rather
"inconceivable" for the kernel.

Jörn

-- 
Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it.
-- Brian W. Kernighan
