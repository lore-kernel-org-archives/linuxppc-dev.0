Return-Path: <David.Daney@caviumnetworks.com>
Received: from mail3.caviumnetworks.com (mail3.caviumnetworks.com
	[12.108.191.235]) by ozlabs.org (Postfix) with ESMTP id C7E4FB6F67
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Jun 2011 09:51:47 +1000 (EST)
Message-ID: <4E09178E.604@cavium.com>
Date: Mon, 27 Jun 2011 16:51:42 -0700
From: David Daney <david.daney@cavium.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/7] serial/8250: move UPIO_TSI to powerpc
References: <1309211120-2803-1-git-send-email-arnd@arndb.de>
	<1309211120-2803-4-git-send-email-arnd@arndb.de>
In-Reply-To: <1309211120-2803-4-git-send-email-arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/27/2011 02:45 PM, Arnd Bergmann wrote:
> This iotype is only used by the legacy_serial code in powerpc, so the
> code should live there, rather than be compiled in for every 8250
> driver.
>
> Signed-off-by: Arnd Bergmann<arnd@arndb.de>
> Cc: Benjamin Herrenschmidt<benh@kernel.crashing.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Greg Kroah-Hartman<gregkh@suse.de>
> Cc: linux-serial@vger.kernel.org
> ---
>   arch/powerpc/kernel/legacy_serial.c |   24 ++++++++++++++++++++++++
>   drivers/tty/serial/8250.c           |   23 -----------------------
>   2 files changed, 24 insertions(+), 23 deletions(-)
>

This seems vaguely familiar:

https://lkml.org/lkml/2008/10/6/297

So just for the hell of it...

Acked-by: David Daney <david.daney@cavium.com>
