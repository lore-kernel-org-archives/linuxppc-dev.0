Return-Path: <glikely@secretlab.ca>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179]) by ozlabs.org (Postfix) with ESMTP id 21312B70AA
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 19 Jul 2010 14:34:18 +1000 (EST)
Received: by gyd10 with SMTP id 10so2158419gyd.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 18 Jul 2010 21:34:16 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <201007191156288194097@gmail.com>
References: <201007161634429622975@gmail.com>
	<AANLkTimXGTg41XHChzcnn75Px_pitC8sPKOY-OlPNIe1@mail.gmail.com>
	<201007191156288194097@gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 18 Jul 2010 22:33:56 -0600
Message-ID: <AANLkTikHO94-Si9G9NSbavpodv4UrTEgJ5Qs4NaAC_dA@mail.gmail.com>
Subject: Re: Re: hi, i have two flashs, but my kernel can only find one , how
	cani write the dts?
To: hacklu <embedway.test@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jul 18, 2010 at 9:56 PM, hacklu <embedway.test@gmail.com> wrote:
>
> thanks very much! it works well now~~
> but i found in my system,if i add the 0x prefix it will cause=A0a syntax =
error

Ah, your dts file is in the old version 0 format.  You must be on an
older kernel, or at least haven't updated your dts file to the new
format after upgrading.

g.
