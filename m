Return-Path: <anton@ozlabs.org>
Date: Mon, 14 Aug 2006 00:44:00 +1000
From: Anton Blanchard <anton@samba.org>
To: Thomas Klein <osstklei@de.ibm.com>
Subject: Re: [PATCH 3/6] ehea: queue management
Message-ID: <20060813144400.GJ479@krispykreme>
References: <44D99F38.8010306@de.ibm.com> <20060811215225.GH479@krispykreme>
	<44DE03B0.1060607@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <44DE03B0.1060607@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	roland@topspin.com, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

> I agree, stubbs were removed.

Thanks.

What is going to be done about the debug infrastructure in the ehea
driver? The entry and exit traces really need to go, and any other debug
you think is important to users needs to go into debugfs or something
similar.

I see a similar issue in the ehca driver that I am in the middle of
reviewing.

Anton
