Return-Path: <timur.tabi@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.26])
	by ozlabs.org (Postfix) with ESMTP id E2F4CDDDB2
	for <linuxppc-dev@ozlabs.org>; Wed,  6 May 2009 05:24:06 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 3so3778043qwe.15
	for <linuxppc-dev@ozlabs.org>; Tue, 05 May 2009 12:24:04 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <20090505191116.GA7267@codiert.org>
References: <20090505191116.GA7267@codiert.org>
Date: Tue, 5 May 2009 14:24:04 -0500
Message-ID: <ed82fe3e0905051224j30a54ef3s3d5e6c88987ea65a@mail.gmail.com>
Subject: Re: [PATCH] Fix wrong register read address and add interrupt
	acknowledge.
From: Timur Tabi <timur@freescale.com>
To: Benjamin Krill <ben@codiert.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, arnd@arndb.de, linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 5, 2009 at 2:11 PM, Benjamin Krill <ben@codiert.org> wrote:
> The receive interrupt routine checks the wrong register if the
> receive fifo is empty. Further an explicit interrupt acknowledge
> write is introduced. In some circumstances another interrupt was
> issued.

The one-line summary of your patch is too vague.  It should mention
the name of the driver somehow.

-- 
Timur Tabi
Linux kernel developer at Freescale
