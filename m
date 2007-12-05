Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by ozlabs.org (Postfix) with ESMTP id 5DBD0DDF20
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Dec 2007 05:15:22 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1026492anc
	for <linuxppc-dev@ozlabs.org>; Wed, 05 Dec 2007 10:15:20 -0800 (PST)
Message-ID: <fa686aa40712051015q3b706f7cv648c98c95e05fa53@mail.gmail.com>
Date: Wed, 5 Dec 2007 11:15:20 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jon Loeliger" <jdl@freescale.com>
Subject: Re: [PATCH] Add aliases node to 8641hpcn DTS file.
In-Reply-To: <1196877907.8544.15.camel@ld0161-tx32>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1196875970.8544.12.camel@ld0161-tx32>
	<fa686aa40712050938j2d286655o94534a00131872e2@mail.gmail.com>
	<1196877907.8544.15.camel@ld0161-tx32>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/5/07, Jon Loeliger <jdl@freescale.com> wrote:
> On Wed, 2007-12-05 at 11:38, Grant Likely wrote:
> > I had thought aliases were supposed to be full paths to nodes instead
> > of phandles.  Was I wrong?
>
> Indeed, that is correct.  And they are!
>
> Grant, you need to keep up, man.  Just this morning
> I pushed Gibson's patch to DTC to support this. :-)

Heh; I'm so behind.  Thanks for the clarification.

g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
