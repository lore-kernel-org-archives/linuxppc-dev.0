Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 8E722B711E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jul 2009 00:45:21 +1000 (EST)
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.233])
	by ozlabs.org (Postfix) with ESMTP id 0A902DDD0C
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Jul 2009 00:45:20 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id b25so342081rvf.9
	for <linuxppc-dev@ozlabs.org>; Wed, 01 Jul 2009 07:45:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090701135547.GD3144@pengutronix.de>
References: <20090629234214.12670.9082.stgit@localhost.localdomain>
	<20090630061847.GA24164@pengutronix.de>
	<9e4733910906300642o4f1c0e2cn45423c426e3aff7e@mail.gmail.com>
	<20090701085633.GB3144@pengutronix.de>
	<9e4733910907010632g10706084o66720d4616e40865@mail.gmail.com>
	<20090701135547.GD3144@pengutronix.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 1 Jul 2009 08:44:58 -0600
Message-ID: <fa686aa40907010744i21beefb2pa088a63fc5bae3d1@mail.gmail.com>
Subject: Re: [PATCH] alsa/soc: add locking to mpc5200-psc-ac97 driver
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 1, 2009 at 7:55 AM, Wolfram Sang<w.sang@pengutronix.de> wrote:
>
>> > Sorry, I didn't get it: Shall I test something specific?
>>
>> I don't own a touchscreen.
>>
>> AFAIK no one has ever plugged a touchscreen into the PCM-973 to see if
>> works since there hasn't been a driver previously.
>> Just do a general
>> test so that you can tell customers that it works.
>
> I am not sure, we have a suitable touchscreen. Also, I am afraid this is a bit
> too much to do besides my regular day work right now. Sorry.

I've now tested this on a client's board which uses the pcm030 with a
custom base board (based on the development board) which uses the same
codec.  It works there.  I don't have a discrete touchscreen to wire
up to the PCM-973 though.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
