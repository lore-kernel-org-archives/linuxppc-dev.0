Return-Path: <SRS0+29e4cc1b6aafbad4109e+1201+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 604B667C4E
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Dec 2006 01:34:22 +1100 (EST)
Subject: Re: Bug report: CELL on linux-2.6.19-git7 won't build,
From: David Woodhouse <dwmw2@infradead.org>
To: Linas Vepstas <linas@austin.ibm.com>
In-Reply-To: <20061206200143.GE17931@austin.ibm.com>
References: <20061206192745.GC17931@austin.ibm.com>
	<45771DC3.8000505@am.sony.com> <20061206200143.GE17931@austin.ibm.com>
Content-Type: text/plain
Date: Thu, 07 Dec 2006 14:34:10 +0000
Message-Id: <1165502050.5253.348.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-12-06 at 14:01 -0600, Linas Vepstas wrote:
> > Yes, that's with CONFIG_HEADERS_CHECK=y.  
> 
> I have to turn that off. Its annoying, actually.

That means it's doing its job :)

The fact that this bug made it all the way into Linus' tree without
getting noticed means that too few people are using it, though.

-- 
dwmw2
