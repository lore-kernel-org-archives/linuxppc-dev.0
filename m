Return-Path: <timur.tabi@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.26])
	by ozlabs.org (Postfix) with ESMTP id 6252B474D7
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 14:33:09 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so5214767qwb.15
	for <linuxppc-dev@ozlabs.org>; Tue, 06 Jan 2009 19:33:07 -0800 (PST)
Message-ID: <ed82fe3e0901061933s2c1bb7ddh842b01ca4204f330@mail.gmail.com>
Date: Tue, 6 Jan 2009 21:33:07 -0600
From: "Timur Tabi" <timur@freescale.com>
Sender: timur.tabi@gmail.com
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: add Ethernet UPSMR definitions to QE library
In-Reply-To: <9CD244E4-FAD2-4CA8-9835-46B6737E4534@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1231283543-26752-1-git-send-email-timur@freescale.com>
	<9CD244E4-FAD2-4CA8-9835-46B6737E4534@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 6, 2009 at 9:21 PM, Kumar Gala <galak@kernel.crashing.org> wrote:
>
> is there some reason to move the defines into this file?

For consistency.  Similar definitions for UART are already in this file.

-- 
Timur Tabi
Linux kernel developer at Freescale
