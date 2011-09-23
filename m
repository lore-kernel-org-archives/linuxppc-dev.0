Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C28C6B6F8B
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Sep 2011 11:12:35 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] drivers/tty: don't use the byte channel handle as a
	parameter in ehv_bytechan.c
Date: Fri, 23 Sep 2011 01:11:55 +0000
Message-ID: <4E7BDCDA.6060506@freescale.com>
References: <1316543217-13769-1-git-send-email-timur@freescale.com>
	<20110922230640.GA16981@kroah.com> <4E7BC1A9.5050708@freescale.com>
	<20110922232828.GA12088@kroah.com>
In-Reply-To: <20110922232828.GA12088@kroah.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-console@vger.kernel.org" <linux-console@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Greg KH wrote:
>>> >  >  This patch doesn't apply at all to my tty tree, what was it made
>>> >  >  against?
>> >
>> >  An internal repository that supposed to be in-sync with the latest an=
d greatest.
>> >
>> >  What's the URL for your tty-next repo?
> There is no public one due to kernel.org being down.
>
> Does your patch apply to linux-next?

It does not, and I see why now.  Looks like the internal tree is not in=20
sync after all.

I will post a V2 shortly.

--=20
Timur Tabi
Linux kernel developer at Freescale=
