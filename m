Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 29089DDDFB
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Jan 2007 14:26:36 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH] Fix sparsemem on Cell (take 3)
Date: Sun, 7 Jan 2007 13:07:50 +0100
References: <20061215165335.61D9F775@localhost.localdomain>
	<1168059162.23226.1.camel@sinatra.austin.ibm.com>
	<1168160307.6740.9.camel@localhost.localdomain>
In-Reply-To: <1168160307.6740.9.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200701071307.52632.arnd@arndb.de>
Cc: Andrew Morton <akpm@osdl.org>, mkravetz@us.ibm.com, linux-mm@kvack.org,
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

On Sunday 07 January 2007 09:58, Dave Hansen wrote:
> The following patch fixes an oops experienced on the Cell architecture
> when init-time functions, early_*(), are called at runtime. =A0It alters
> the call paths to make sure that the callers explicitly say whether the
> call is being made on behalf of a hotplug even, or happening at
> boot-time.=20
>=20
> It has been compile tested on ia64, s390, i386 and x86_64.

I can't test it here, since I'm travelling at the moment, but
this version looks good to me. Thanks for picking it up again!

> Signed-off-by: Dave Hansen <haveblue@us.ibm.com>

Acked-by: Arnd Bergmann <arndb@de.ibm.com>
