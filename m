Return-Path: <tpepper@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by ozlabs.org (Postfix) with ESMTP id 970F2DDE27
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Jan 2007 17:47:50 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so2758363ugf
	for <linuxppc-dev@ozlabs.org>; Sun, 07 Jan 2007 22:47:48 -0800 (PST)
Message-ID: <eada2a070701072247w165f9beem6d24ec8e3325c6f3@mail.gmail.com>
Date: Sun, 7 Jan 2007 22:47:47 -0800
From: "Tim Pepper" <tpepper@gmail.com>
To: "Dave Hansen" <haveblue@us.ibm.com>
Subject: Re: [PATCH] Fix sparsemem on Cell (take 3)
In-Reply-To: <1168160307.6740.9.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20061215165335.61D9F775@localhost.localdomain>
	<200612182354.47685.arnd@arndb.de>
	<1166483780.8648.26.camel@localhost.localdomain>
	<200612190959.47344.arnd@arndb.de>
	<1168045803.8945.14.camel@localhost.localdomain>
	<1168059162.23226.1.camel@sinatra.austin.ibm.com>
	<1168160307.6740.9.camel@localhost.localdomain>
Cc: Andrew Morton <akpm@osdl.org>, mkravetz@us.ibm.com,
	Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org,
	lkml <linux-kernel@vger.kernel.org>, hch@infradead.org,
	External List <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, kmannth@us.ibm.com, gone@us.ibm.com,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/7/07, Dave Hansen <haveblue@us.ibm.com> wrote:
> On Fri, 2007-01-05 at 22:52 -0600, John Rose wrote:
> > Could this break ia64, given that it uses memmap_init_zone()?
>
> You are right, I think it does.

Boot tested OK on ia64 with this latest version of the patch.

(forgot to click plain text on gmail the first time..sorry if you got
html mail or repeat)


Tim
