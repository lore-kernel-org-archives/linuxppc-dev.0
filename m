Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 33A222C00C3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Oct 2013 05:50:23 +1100 (EST)
To: Scott Wood <scottwood@freescale.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH] [RFC] Emulate "lwsync" to run standard user land on e500
 cores
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
In-reply-to: <1382114321.7979.840.camel@snotra.buserror.net>
References: <1382081880-6666-1-git-send-email-wd@denx.de>
 <1382114321.7979.840.camel@snotra.buserror.net>
Date: Fri, 18 Oct 2013 20:50:11 +0200
Message-Id: <20131018185011.6C45A380627@gemini.denx.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Scott,

In message <1382114321.7979.840.camel@snotra.buserror.net> you wrote:
>
> There's already been a patch posted for this:
> http://patchwork.ozlabs.org/patch/256747/
> 
> I plan to apply it for my next pull request.

Ah, cool.  Thanks!

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"It is better to have tried and failed than to have  failed  to  try,
but the result's the same."                           - Mike Dennison
