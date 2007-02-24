Return-Path: <bwarren@qstreams.com>
Received: from web307.biz.mail.mud.yahoo.com (web307.biz.mail.mud.yahoo.com
	[68.142.199.183]) by ozlabs.org (Postfix) with SMTP id A0814DDE10
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 24 Feb 2007 14:25:19 +1100 (EST)
Date: Fri, 23 Feb 2007 19:25:18 -0800 (PST)
From: Ben Warren <bwarren@qstreams.com>
Subject: Re: [PATCH] jffs2 file system
To: Nethra <nethra_gmit@yahoo.co.in>, linuxppc-embedded@ozlabs.org
In-Reply-To: <9130617.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <10456.15332.qm@web307.biz.mail.mud.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--- Nethra <nethra_gmit@yahoo.co.in> wrote:

> 
> 
>  thanks ben,
> 
> I have already tried to build jffs2 image as per
> link mentioned using
> mkfs.jffs2 utility, but mkfs.jffs2 is absent in
> host...so i downloded
> mkfs.jffs2 from net and used the same to create the
> image.Is it the correct
> way?
> 

Sounds reasonable.

> it is giveing error when booting...
> 
> nethra

OK, what's the error?  Did you set the endianness
correctly when using mkfs.jffs2?
