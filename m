Return-Path: <gnomes@lxorguk.ukuu.org.uk>
Received: from fuzix.org (www.llwyncelyn.cymru [82.70.14.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 429Q4s0hKbzF35x
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 01:02:52 +1000 (AEST)
Date: Wed, 12 Sep 2018 15:41:19 +0100
From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To: Jaejoong Kim <climbbb.kim@gmail.com>
Cc: linux-um@lists.infradead.org, netdev@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org,
 devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
 linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH 00/25] Change tty_port(standard)_install's return type
Message-ID: <20180912154119.1fce639d@alans-desktop>
In-Reply-To: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
References: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue,  4 Sep 2018 11:44:26 +0900
Jaejoong Kim <climbbb.kim@gmail.com> wrote:

> Many drivers with tty use the tty_stand_install(). But, there is no
> need to handle the error, since it always returns 0.


And what happens if another change means it can fail again. It's just a
property of the current implementation that it can't. It used to fail.

This seems to be a ton of unneccessary churn that will end up just having
to be reversed again some day in the future.

Alan
