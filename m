Return-Path: <timur.tabi@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.24])
	by ozlabs.org (Postfix) with ESMTP id 5EFA6DE0A6
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 08:49:14 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 3so2381446qwe.15
	for <linuxppc-dev@ozlabs.org>; Mon, 18 May 2009 15:49:12 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <fa686aa40905140910i194acbd7y34142720874b8299@mail.gmail.com>
References: <1241560385-26868-1-git-send-email-timur@freescale.com>
	<fa686aa40905140813l5caf7085r64bce935be0a22d3@mail.gmail.com>
	<4A0C40D4.1090508@freescale.com>
	<fa686aa40905140910i194acbd7y34142720874b8299@mail.gmail.com>
Date: Mon, 18 May 2009 17:49:12 -0500
Message-ID: <ed82fe3e0905181549n6d9a5370rcc0e1f52cebdc2d3@mail.gmail.com>
Subject: Re: [PATCH v7] introduce macro spin_event_timeout()
From: Timur Tabi <timur@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org, smaclennan@pikatech.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 14, 2009 at 11:10 AM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> In other words, write your patches which use it and submit the lot as
> a patch series with this patch as the first. =A0That gives some evidence
> that this macro will actually be used and useful.

This is going to be more difficult than you think.  The problem is
that I don't have access to much hardware that uses drivers which can
take advantage of this macro.  I can find one, maybe two examples, but
if I put a timeout that's too short, I might break some other platform
without knowing it.

--=20
Timur Tabi
Linux kernel developer at Freescale
