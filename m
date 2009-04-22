Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 95C07DE0FB
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 04:11:02 +1000 (EST)
To: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [OT] Lite5200B w/ nfs root hangs after some time
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <1240422181.5492.0@antares>
References: <1240422181.5492.0@antares>
Date: Wed, 22 Apr 2009 20:10:59 +0200
Message-Id: <20090422181059.7510A83420E8@gemini.denx.de>
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Albrecht =?iso-8859-1?b?RHJl3w==?=,

In message <1240422181.5492.0@antares> you wrote:
>
> this question is maybe off-topic on this list...

This is not off topic (actually, if you had bothered to check the
mailing ist archives before posting, you would have known - because
you would have found previous discussions of this issue, including the
necessary fix).

> I use the Lite5200B board with stock kernel 2.6.29, and boot with the  

That's known to show this problem.

> [ 4912.350855] nfs: server 10.16.10.29 not responding, still trying

well known symptom.

> an the the system is *completely* dead, i.e. it doesn't respond to  

No, it is NOT completely dead, just extremely slow.

> Any idea what goes wrong here, and how I could fix it?

Apply this patch:

http://patchwork.ozlabs.org/patch/24487/

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
When all is said and done, more is said than done.
