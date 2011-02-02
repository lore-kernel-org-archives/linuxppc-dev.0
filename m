Return-Path: <diggskevin38@gmail.com>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8A759B7101
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Feb 2011 09:09:33 +1100 (EST)
Received: by iye19 with SMTP id 19so458935iye.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 02 Feb 2011 14:09:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <AANLkTi=xM5qt4sic-YBD87Znt0vVOyX2yOyhODhtKNqC@mail.gmail.com>
References: <AANLkTikAVgH9-UQfrjoAJSemet5p_PxhxCdot8cChQu3@mail.gmail.com>
	<AANLkTim6v25Sam+E8Bo9za1q0GJqWZitgqR0KBuKCoWz@mail.gmail.com>
	<AANLkTik9ejmu2vE13f_nRZZMspU-LW4y2=74iczoXGNt@mail.gmail.com>
	<AANLkTikGK-7JspQMTiqjXcvoP1FVSt2gZJ9SRqGj=7DO@mail.gmail.com>
	<1296682842.2349.730.camel@pasglop>
	<AANLkTi=xM5qt4sic-YBD87Znt0vVOyX2yOyhODhtKNqC@mail.gmail.com>
Date: Wed, 2 Feb 2011 16:09:30 -0600
Message-ID: <AANLkTin+1pENJ_CNQGoPA=Hisv4qkJWCE01uyZEXipNu@mail.gmail.com>
Subject: Re: BootX
From: kevin diggs <diggskevin38@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

And one more thing:  Why does an SMP kernel (mesh compiled in an SMP
enabled kernel) work?

What all does SMP do? If it matters, I'm voluntary preempt.

Is the DMA hardware in this thing used in any other system (I guess I
mean both other computers and other sub-systems in this computer -
does the 53c94 use it? The audio uses it, right?)?

kevin
