Return-Path: <timur.tabi@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id A2223DDEE3
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 03:47:53 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so400884yxb.39
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 08:47:51 -0800 (PST)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <f234e2140902120251t2bd3aa5dsc950cacdd6b4422a@mail.gmail.com>
References: <f234e2140902110043i5a4aefb5yb635bc32b9653943@mail.gmail.com>
	<1234343703.9778.13.camel@localhost>
	<f234e2140902110141l52550ceem664f57f697bd48e0@mail.gmail.com>
	<1234346072.9778.20.camel@localhost>
	<f234e2140902110213g3ae48f2es9fe41087bc8c7b39@mail.gmail.com>
	<20090211223546.GA20129@cynthia.pants.nu>
	<f234e2140902120251t2bd3aa5dsc950cacdd6b4422a@mail.gmail.com>
Date: Thu, 12 Feb 2009 10:39:36 -0600
Message-ID: <ed82fe3e0902120839q54793762uc9b180a82cad45c7@mail.gmail.com>
Subject: Re: request_irq return errno 38
From: Timur Tabi <timur@freescale.com>
To: Vijay Nikam <vijay.t.nikam@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 12, 2009 at 4:51 AM, Vijay Nikam <vijay.t.nikam@gmail.com> wrote:

> Also how I can read the device tree binary file ? ? ?

It would be a lot simpler if you just read the documentation (see
booting-without-of.txt) and looked at other device drivers to see what
they do.

-- 
Timur Tabi
Linux kernel developer at Freescale
