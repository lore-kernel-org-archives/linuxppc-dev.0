Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 64644DDF9B
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 08:09:57 +1000 (EST)
To: Scott Wood <scottwood@freescale.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 02/12] fs_enet: Add MPC5121 FEC support.
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <4A01F602.2010601@freescale.com>
References: <1241640919-4650-1-git-send-email-wd@denx.de>
	<1241640919-4650-3-git-send-email-wd@denx.de>
	<4A01F602.2010601@freescale.com>
Date: Thu, 07 May 2009 00:09:54 +0200
Message-Id: <20090506220954.5D3AF83420E8@gemini.denx.de>
Cc: John Rigby <jrigby@gmail.com>, linuxppc-dev@ozlabs.org,
	Piotr Ziecik <kosmo@semihalf.com>, Detlev Zundel <dzu@denx.de>,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Scott,

in message <4A01F602.2010601@freescale.com> you wrote:
>
> All of the above is duplicative (with even the same names) of stuff in 
> asm/cpm.h.  Beyond just the duplication, what happens if both CPM2 and 

OK, I can try to reuse the definitions from that file.

> 512x are enabled in the same kernel?

Hm... both architectures look sufficiently different to me that I
don't see sense in trying such a thing. Do you think that needs to be
supported?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"You ain't experienced..." "Well, nor are you." "That's true. But the
point is ... the point is ... the point is we've been not experienced
for a lot longer than you. We've got  a  lot  of  experience  of  not
having any experience."           - Terry Pratchett, _Witches Abroad_
