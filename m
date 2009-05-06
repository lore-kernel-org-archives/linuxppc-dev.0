Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 04285DDE06
	for <linuxppc-dev@ozlabs.org>; Wed,  6 May 2009 10:43:23 +1000 (EST)
Date: Tue, 5 May 2009 20:43:18 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: [PATCH v7] introduce macro spin_event_timeout()
Message-ID: <20090505204318.6a37995f@lappy.seanm.ca>
In-Reply-To: <1241560385-26868-1-git-send-email-timur@freescale.com>
References: <1241560385-26868-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue,  5 May 2009 16:53:05 -0500
"Timur Tabi" <timur@freescale.com> wrote:

> The macro spin_event_timeout() takes a condition and timeout value
> (in microseconds) as parameters.  It spins until either the condition
> is true or the timeout expires.  It returns the result of the
> condition when the loop was terminated.
> 
> This primary purpose of this macro is to poll on a hardware register
> until a status bit changes.  The timeout ensures that the loop still
> terminates if the bit doesn't change as expected.  This macro makes
> it easier for driver developers to perform this kind of operation
> properly.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>

Nice. I could have used a routine like this in a couple of our drivers.
So, for what it is worth:

Acked-by: Sean MacLennan <smaclennan@pikatech.com>

Cheers,
   Sean
