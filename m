Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 670D3DDEFE
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Dec 2008 16:37:30 +1100 (EST)
Date: Sat, 20 Dec 2008 00:37:04 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Felix Radensky" <felix@embedded-sol.com>
Subject: Re: Long boot delay on 460EX with 2.6.28-rc8
Message-ID: <20081220003704.26bfb042@lappy.seanm.ca>
In-Reply-To: <494C10EE.1040305@embedded-sol.com>
References: <21070179.post@talk.nabble.com>
	<20081218190208.GC18201@yoda.jdub.homelinux.org>
	<21087072.post@talk.nabble.com> <200812190856.19482.sr@denx.de>
	<494C10EE.1040305@embedded-sol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 19 Dec 2008 23:23:58 +0200
"Felix Radensky" <felix@embedded-sol.com> wrote:

> Hi, Sean
> 
> Do you have any ideas what can cause such delay ?

Sorry, I haven't been following this thread :(

We also use a 256M NAND, although a Spansion S29GL. While there is a
small delay in u-boot, there is no noticeable during the ndfc startup.

Can you read and write the NAND properly in u-boot? That is always the
first step. If that works, we can look at what might be different
between the u-boot and the ndfc driver.

Cheers,
   Sean
