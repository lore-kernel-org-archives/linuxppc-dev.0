Return-Path: <timur.tabi@gmail.com>
Received: from mail-qy0-f123.google.com (mail-qy0-f123.google.com
	[209.85.221.123]) by ozlabs.org (Postfix) with ESMTP id 391C7DDE22
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 08:48:36 +1000 (EST)
Received: by qyk29 with SMTP id 29so3741238qyk.17
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 15:48:35 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <1240859144-20893-1-git-send-email-timur@freescale.com>
References: <1240859144-20893-1-git-send-email-timur@freescale.com>
Date: Wed, 29 Apr 2009 17:48:34 -0500
Message-ID: <ed82fe3e0904291548g88c2ebdo903c179725aa7047@mail.gmail.com>
Subject: Re: [PATCH v6] introduce macro spin_event_timeout()
From: Timur Tabi <timur@freescale.com>
To: linuxppc-dev@ozlabs.org, galak@kernel.crashing.org,
	benh@kernel.crashing.org, jwboyer@linux.vnet.ibm.com,
	scottwood@freescale.com
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 27, 2009 at 2:05 PM, Timur Tabi <timur@freescale.com> wrote:
> The macro spin_event_timeout() takes a condition and timeout value
> (in microseconds) as parameters. =A0It spins until either the condition i=
s true
> or the timeout expires. =A0It returns the result of the condition when th=
e loop
> was terminated.
>
> This primary purpose of this macro is to poll on a hardware register unti=
l a
> status bit changes. =A0The timeout ensures that the loop still terminates=
 if the
> bit doesn't change as expected. =A0This macro makes it easier for driver
> developers to perform this kind of operation properly.

Any comments on this patch?  I'd like to see this macro added to 2.6.31.

--=20
Timur Tabi
Linux kernel developer at Freescale
