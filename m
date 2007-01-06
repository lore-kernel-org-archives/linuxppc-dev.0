Return-Path: <johnrose@austin.ibm.com>
Subject: Re: [PATCH] Fix sparsemem on Cell (take 3)
From: John Rose <johnrose@austin.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <1168045803.8945.14.camel@localhost.localdomain>
References: <20061215165335.61D9F775@localhost.localdomain>
	<200612182354.47685.arnd@arndb.de>
	<1166483780.8648.26.camel@localhost.localdomain>
	<200612190959.47344.arnd@arndb.de>
	<1168045803.8945.14.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1168059162.23226.1.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
Date: Fri, 05 Jan 2007 22:52:42 -0600
Cc: Andrew Morton <akpm@osdl.org>, mkravetz@us.ibm.com,
	Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org,
	lkml <linux-kernel@vger.kernel.org>, hch@infradead.org,
	External List <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, kmannth@us.ibm.com,
	gone@us.ibm.com, cbe-oss-dev@ozlabs.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I dropped this on the floor over Christmas.  This has had a few smoke
> tests on ppc64 and i386 and is ready for -mm.  Against 2.6.20-rc2-mm1.

Could this break ia64, given that it uses memmap_init_zone()?
