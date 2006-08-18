Return-Path: <anton@ozlabs.org>
Date: Sat, 19 Aug 2006 01:13:40 +1000
From: Anton Blanchard <anton@samba.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [2.6.19 PATCH 2/7] ehea: pHYP interface
Message-ID: <20060818151340.GB27947@krispykreme>
References: <200608181330.21507.ossthema@de.ibm.com>
	<20060818150600.GG5201@martell.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060818150600.GG5201@martell.zuzino.mipt.ru>
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>, Thomas Klein <osstklei@de.ibm.com>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 
Hi,

> I asked SO to recount arguments and we've come to a conclusion that
> there're in fact 19 args not 18 as the name suggests. 19 args is
> I-N-S-A-N-E.

It will be partially cleaned up by:

http://ozlabs.org/pipermail/linuxppc-dev/2006-July/024556.html

However it doesnt fix the fact someone has architected such a crazy
interface :(

Anton
