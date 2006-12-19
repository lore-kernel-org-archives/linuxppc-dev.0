Return-Path: <kamezawa.hiroyu@jp.fujitsu.com>
Date: Tue, 19 Dec 2006 09:16:25 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH] Fix sparsemem on Cell
Message-Id: <20061219091625.43d45893.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <1166483780.8648.26.camel@localhost.localdomain>
References: <20061215165335.61D9F775@localhost.localdomain>
	<20061215114536.dc5c93af.akpm@osdl.org>
	<20061216170353.2dfa27b1.kamezawa.hiroyu@jp.fujitsu.com>
	<200612182354.47685.arnd@arndb.de>
	<1166483780.8648.26.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: akpm@osdl.org, mkravetz@us.ibm.com, arnd@arndb.de, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, hch@infradead.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org, kmannth@us.ibm.com,
	gone@us.ibm.com, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 18 Dec 2006 15:16:20 -0800
Dave Hansen <haveblue@us.ibm.com> wrote:

> enum context
> {
>         EARLY,
>         HOTPLUG
> };
I like this :)

Thanks,
-Kame
