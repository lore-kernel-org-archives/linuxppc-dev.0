Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 32482DDEA3
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 04:15:55 +1000 (EST)
Message-ID: <46951ED3.6050206@ru.mvista.com>
Date: Wed, 11 Jul 2007 22:17:55 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: Tickless Hz/hrtimers/etc. on PowerPC
References: <46951C1A.4080001@genesi-usa.com>
In-Reply-To: <46951C1A.4080001@genesi-usa.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Matt Sealey wrote:

> Does anyone have the definitive patchset to enable the tickless hz,
> some kind of hrtimer and the other related improvements in the
> PowerPC tree?

    Look into the -rt patch which has the all this (minus TOD vsyscalls).

MBR, Sergei
