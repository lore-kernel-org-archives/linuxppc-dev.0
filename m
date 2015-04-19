Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7A9371A0BDC
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Apr 2015 18:56:20 +1000 (AEST)
To: Ajit Phadnis <ajitsp2001@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: uboot parsing
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
In-reply-to: <CAKNr0CiLK3bfGWzuwEs1KHqeCan6q5bPJ2psn6gNmBTobCS3Ug@mail.gmail.com>
References: <CAKNr0CiLK3bfGWzuwEs1KHqeCan6q5bPJ2psn6gNmBTobCS3Ug@mail.gmail.com>
Date: Sun, 19 Apr 2015 10:50:23 +0200
Message-Id: <20150419085023.71726380907@gemini.denx.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Ajit Phadnis,

In message <CAKNr0CiLK3bfGWzuwEs1KHqeCan6q5bPJ2psn6gNmBTobCS3Ug@mail.gmail.com> you wrote:
>
> Would like to how to store the response command of a run command

You should ask U-Boot related questions on the U-Boot mailing list [1] 
instead; chances for a helpful reply are much better there than on
lists that do not actually deal with U-Boot.

> Would to store the outcome of  "run addr" in into a variable and grep for
> the characters or string in Uboot.

Unfortunately, there is currently no way (yet) to do that.  When the
hush shell was ported to U-Boot, it was configured and modified for
minimal memory footprint; one of the features that have not been
included is command substitution.

If you really need such a feature, you could port (or have ported) a
more recent version of hush and include this feature.  Today's systems
usually have much more resources than we had at the time when hush was
added, so the additional memory footprint should be acceptable
(especially if you make that option configurable, so those who are not
interested in it or are already tight on memory can opt out).

Further discussions should be done on the U-Boot list [1].

[1] http://lists.denx.de/mailman/listinfo/u-boot


Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
In an organization, each person rises to the level of his own  incom-
petency                                         - The Peter Principle
