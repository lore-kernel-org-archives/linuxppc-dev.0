Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id 10866DDF96
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 10:05:56 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so164339yxb.39
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 17:05:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090422181059.7510A83420E8@gemini.denx.de>
References: <1240422181.5492.0@antares>
	<20090422181059.7510A83420E8@gemini.denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 22 Apr 2009 18:05:40 -0600
Message-ID: <fa686aa40904221705r24f8093bn74d336ddc2b8edaf@mail.gmail.com>
Subject: Re: [OT] Lite5200B w/ nfs root hangs after some time
To: Wolfgang Denk <wd@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>,
	Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 22, 2009 at 12:10 PM, Wolfgang Denk <wd@denx.de> wrote:
> In message <1240422181.5492.0@antares> you wrote:
>> Any idea what goes wrong here, and how I could fix it?
>
> Apply this patch:
>
> http://patchwork.ozlabs.org/patch/24487/

No, that's not the problem in this case.  2.6.29 networking is broken
for a lot of platforms, not just mpc5200.  Use 2.6.29.1 instead.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
