Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 287252BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 Nov 2004 13:18:42 +1100 (EST)
In-Reply-To: <20041116015539.39185.qmail@web15608.mail.cnb.yahoo.com>
References: <20041116015539.39185.qmail@web15608.mail.cnb.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <34E4EF1E-3776-11D9-A70B-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Mon, 15 Nov 2004 21:21:21 -0500
To: Sam Song <samlinuxppc@yahoo.com.cn>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Any possibility of common mini test kernel for 8xx/82xx/85xx?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Nov 15, 2004, at 8:55 PM, Sam Song wrote:

> Could you pls offer the cute one to us?

I think it's a great exercise for the reader :-)
Just pick an 8xx distribution and make a small
ramdisk that boots to a shell prompt.  I'm not
a busybox fan, but if you want that you could do
that one, too.  The 8xx distribution will run on
any PowerPC core.

	-- Dan
