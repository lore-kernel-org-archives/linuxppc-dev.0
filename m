Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.243])
	by ozlabs.org (Postfix) with ESMTP id 7B05FDE0BB
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 00:25:21 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so101627anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 06:25:19 -0700 (PDT)
Message-ID: <fa686aa40803270625p1d965cabhe326fd8cda3d20cb@mail.gmail.com>
Date: Thu, 27 Mar 2008 07:25:19 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Matt Sealey" <matt@genesi-usa.com>
Subject: Re: Missing patch for MPC5200B register definitions?
In-Reply-To: <47EA7E72.3010502@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47EA7687.5000102@genesi-usa.com> <47EA7E72.3010502@genesi-usa.com>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 26, 2008 at 10:48 AM, Matt Sealey <matt@genesi-usa.com> wrote:
> Oh yes, I forgot.. also, the new MPC5121E stuff includes a lot of unions and
>  defines to make using both PSC formats easier.
>
>  Since the MPC5200 and MPC5200B PSC structures are different (CCR size), can the
>  original suggestion (in that thread) to support both with a union and some
>  defines to make supporting both CCR sizes, be implemented, or do we still think
>  that MPC5200 (not B) is not worth supporting?

Until someone writes a driver actually using it; let's pretend it
doesn't exist.  :-)  It's not too difficult to add it back in at a
later date if someone does decide to support it.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
