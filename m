Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D1D0F1A0BDC
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Apr 2015 19:01:20 +1000 (AEST)
To: Kiran Kumar <kiran1677@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Regarding storing and parsing in Uboot
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
In-reply-to: <CAPbBx=5chsiOxT+GiEX19At6p-pCaa7GckZFUPYo-7YGuphN2g@mail.gmail.com>
References: <CAPbBx=5chsiOxT+GiEX19At6p-pCaa7GckZFUPYo-7YGuphN2g@mail.gmail.com>
Date: Sun, 19 Apr 2015 10:53:04 +0200
Message-Id: <20150419085304.31FEF380907@gemini.denx.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Kiran,

arghhh... Please do not post the same question in several messages to
many addrresses; if you really feel you need to send it to all, then
please put all on Cc: so all can receive the replies, too.

I answered before:

In message <CAPbBx=45O4UrKLoVjCvg5wEnTab-dGo=-O5SH6OwgD49Cq6w+Q@mail.gmail.com> you wrote:
> 
> In uboot, i run some IPMI commands and I have to store that value in uboot
> and also extract the interim byte of the output value.

I'm afraid we cannot help you with that.  We know only the mainline
code of U-Boot, and this does not include any kind of IPMI support.
Apparently you are using some vendor version with specific extensions.
Without knowing this code it is impossible for us to help you, sorry.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The reasonable man adapts himself to the world; the unreasonable  one
persists  in  trying  to  adapt  the  world to himself. Therefore all
progress depends on the unreasonable man."      - George Bernard Shaw
