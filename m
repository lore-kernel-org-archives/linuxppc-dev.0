Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7F043DDECD
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 23:32:59 +1000 (EST)
In-Reply-To: <18032.40447.579128.989284@cargo.ozlabs.ibm.com>
References: <20070612163016.253915076@arndb.de>
	<18032.40447.579128.989284@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B4E893D5-A61E-4A91-B31C-AF9B7C0B116D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [patch 00/13] CPU selection Kconfig cleanup, take 3
Date: Thu, 14 Jun 2007 08:33:19 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, arnd@arndb.de,
	Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 13, 2007, at 8:46 PM, Paul Mackerras wrote:

> Most of this series of patches touch 8xxx or 5xxx stuff in one way or
> another, so I'll leave it to Kumar to make the decision about them.
> I'll put in 1/13.

Arnd,

I'm a little hesitant to move the embedded ppc's over to  
multiplatform quite yet.  One feature I wanted was in Kconfig a way  
to enforce the selection of at least one choice, as well as being  
able to optimize things since we only had one choice selected.

See the following thread for discussion I had with Sam & Roman on the  
subject:

http://marc.info/?t=117156757000002&r=1&w=2

- k
