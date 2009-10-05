Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f173.google.com (mail-iw0-f173.google.com
	[209.85.223.173]) by ozlabs.org (Postfix) with ESMTP id A60F1B7BD9
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Oct 2009 00:47:13 +1100 (EST)
Received: by iwn3 with SMTP id 3so1661873iwn.17
	for <linuxppc-dev@ozlabs.org>; Mon, 05 Oct 2009 06:47:12 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4AC9C6AA.6060009@denx.de>
References: <4AADF93C.3030604@denx.de> <20090914080322.GA3164@pengutronix.de>
	<fa686aa40909140745u2cf1dba7q8ae2af53c87bd216@mail.gmail.com>
	<4AC9A463.1080903@denx.de> <20091005095340.GA3890@pengutronix.de>
	<4AC9C6AA.6060009@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 5 Oct 2009 07:46:52 -0600
Message-ID: <fa686aa40910050646p168c2bbfi4b432778827102c9@mail.gmail.com>
Subject: Re: [PATCH v2] mpc5200: support for the MAN mpc5200 based board uc101
To: hs@denx.de
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 5, 2009 at 4:12 AM, Heiko Schocher <hs@denx.de> wrote:
> Wolfram Sang wrote:
>> Is this an official binding? I also did an gpio-watchdog a while ago and there
>> were some issues with the binding, IIRC. Would be nice if this has been solved
>> meanwhile.
>
> Oh, sorry, no. I remove it.

You don't need to remove it, but choose a compatible value within the
board/manufacturer namespace.  ie. 'manroland,uc101-watchdog'.  You
also need to document what it means in
Documentation/powerpc/dts-bindings/.  If you do want to do some kind
of generic gpio watchdog binding, then write a documentation patch for
it and post it to devicetree-discuss for review.  Make sure you cc:
both me and Wolfram when you post it.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
