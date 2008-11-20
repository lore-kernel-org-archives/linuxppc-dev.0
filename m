Return-Path: <jwboyer@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.24])
	by ozlabs.org (Postfix) with ESMTP id 1A6E4DDE0A
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 01:14:04 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so87707qwb.15
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2008 06:14:02 -0800 (PST)
Date: Thu, 20 Nov 2008 09:13:45 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Add support for the nwp serial device
Message-ID: <20081120141345.GA2410@yoda.jdub.homelinux.org>
References: <200811201501.24000.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200811201501.24000.arnd@arndb.de>
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 20, 2008 at 03:01:23PM +0100, Arnd Bergmann wrote:
>From: Benjamin Krill <ben@codiert.org>
>
>This patch adds support for the nwp serial device which is connected to
>a DCR bus. It uses the of_serial device driver to determine necessary
>properties from the device tree. The supported device is added as serial
>port number 84.

What does 'NWP' stand for, and how is it different from a regular serial
port?  Also, what platforms can this device be found on currently?

Some of that should be included in the changelog, but I'm curious as well
too.

josh
