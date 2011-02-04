Return-Path: <diggskevin38@gmail.com>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BB909B711E
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  5 Feb 2011 04:21:41 +1100 (EST)
Received: by iye19 with SMTP id 19so2479397iye.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 04 Feb 2011 09:21:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1296685762.2349.739.camel@pasglop>
References: <AANLkTikAVgH9-UQfrjoAJSemet5p_PxhxCdot8cChQu3@mail.gmail.com>
	<AANLkTim6v25Sam+E8Bo9za1q0GJqWZitgqR0KBuKCoWz@mail.gmail.com>
	<AANLkTik9ejmu2vE13f_nRZZMspU-LW4y2=74iczoXGNt@mail.gmail.com>
	<AANLkTikGK-7JspQMTiqjXcvoP1FVSt2gZJ9SRqGj=7DO@mail.gmail.com>
	<1296682842.2349.730.camel@pasglop>
	<AANLkTi=xM5qt4sic-YBD87Znt0vVOyX2yOyhODhtKNqC@mail.gmail.com>
	<AANLkTin+1pENJ_CNQGoPA=Hisv4qkJWCE01uyZEXipNu@mail.gmail.com>
	<1296685762.2349.739.camel@pasglop>
Date: Fri, 4 Feb 2011 11:21:37 -0600
Message-ID: <AANLkTikxL1ZrTmKLvQ--JDZyu=80AM8kUUhi4BGNLz0O@mail.gmail.com>
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

FYI:

This driver has some pretty good diagnostics/debug capabilities built
in. Once that is enabled it shows that the inquiry works and the sync
negotiation works. The next command (I think) is test unit ready,
which does not work. It is retried multiple times. The result is 20000
which I think is DID_BUS_BUSY. Probably in mesh_start_cmd(), possibly
something off in the loop at line 462?

kevin

P.S.:  I posted some documentation for dump_stack()/show_stack() but
have not heard anything? Is that not something we are interested in
doing?
