Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by ozlabs.org (Postfix) with ESMTP id DCB5ADE0A1
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 16:41:19 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so816509anc.78
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 23:41:08 -0700 (PDT)
Message-ID: <fa686aa40804162341h5e68e460t975f69118ff8beca@mail.gmail.com>
Date: Wed, 16 Apr 2008 23:41:08 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Robert Schwebel" <r.schwebel@pengutronix.de>
Subject: Re: mpc5200: add interrupt type function
In-Reply-To: <20080417060031.GH13814@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080415152954.GX13814@pengutronix.de>
	<20080417060031.GH13814@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 16, 2008 at 11:00 PM, Robert Schwebel
<r.schwebel@pengutronix.de> wrote:
> On Tue, Apr 15, 2008 at 05:29:54PM +0200, Robert Schwebel wrote:
>  > From: Sascha Hauer <s.hauer@pengutronix.de>
>  >
>  > Add a set_type function for external (GPIO) interrupts.
>  >
>  > Signed-off-by: Juergen Beisert <j.beisert@pengutronix.de>
>  > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>
>  As we didn't get negative feedback yet, could this go into the 2.6.26
>  merge window?

I didn't see this the first time (didn't get cc'd).

It looks mostly okay, but in doesn't have any mutual exclusion which
it probably should have.  What are the users of this?

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
