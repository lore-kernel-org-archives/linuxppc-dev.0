Return-Path: <jacmet@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.201])
	by ozlabs.org (Postfix) with ESMTP id 3283568294
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Sep 2005 00:42:31 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 68so2124447wri
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Sep 2005 07:42:30 -0700 (PDT)
Message-ID: <9305ca4105091307345aa64870@mail.gmail.com>
Date: Tue, 13 Sep 2005 16:34:20 +0200
From: Peter Korsgaard <jacmet@gmail.com>
To: Jeff Stevens <jsteve17@yahoo.com>
In-Reply-To: <20050913121748.66647.qmail@web33013.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20050913121748.66647.qmail@web33013.mail.mud.yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: USB root filesytem using a 2.6 kernel?
Reply-To: jacmet@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 9/13/05, Jeff Stevens <jsteve17@yahoo.com> wrote:
> Has anyone had any luck booting from a linux filesytem
> on a USB pen drive running 2.6?

It's a timing issue - your USB stick doesn't get detected / scanned
for partitions before the kernel tries to mount the rootfs. Use the
rootdelay kernel parameter to force a delay (of E.G. 10s) to fix it.

You might need to upgrade your kernel through, I think it was added in 2.6.=
11

--=20
Bye, Peter Korsgaard
