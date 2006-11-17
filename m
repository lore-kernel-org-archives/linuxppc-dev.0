Return-Path: <anton@ozlabs.org>
Date: Fri, 17 Nov 2006 16:21:58 +1100
From: Anton Blanchard <anton@samba.org>
To: Jimi Xenidis <jimix@watson.ibm.com>
Subject: Re: [PATCH 5/16] hypervisor functions for Celleb
Message-ID: <20061117052158.GB670@krispykreme>
References: <200611150937.kAF9b305001499@toshiba.co.jp>
	<20061115183746.GC21633@lst.de> <200611152304.45243.arnd@arndb.de>
	<45AC8C44-8193-4311-B4BF-BF7FF56C8DF4@watson.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45AC8C44-8193-4311-B4BF-BF7FF56C8DF4@watson.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Just make another one (or a set of them like the phyp calls) and  
> define then in assembly.
> Certainly a bl to a function will be negligible to the hcall its self.

Agreed. And I thought the phyp hcall code was ugly :)

Any ideas why its so different? Just NIH?

Anton
