Return-Path: <matthias.fuchs@esd-electronics.com>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 033D0DDDE6
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Sep 2008 21:54:26 +1000 (EST)
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc/44x: Add hwmon support to Sequoia device tree
Date: Tue, 9 Sep 2008 13:52:29 +0200
References: <200809041155.02927.matthias.fuchs@esd-electronics.com>
	<48C29CA3.80806@grandegger.com>
	<20080908160332.GA12679@ld0162-tx32.am.freescale.net>
In-Reply-To: <20080908160332.GA12679@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200809091352.29472.matthias.fuchs@esd-electronics.com>
Cc: linuxppc-dev@ozlabs.org, Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 08 September 2008 18:03, Scott Wood wrote:
> On Sat, Sep 06, 2008 at 05:07:15PM +0200, Wolfgang Grandegger wrote:
> > How about "dtt"? That's what we use in U-Boot for digital temperature
> > sensors as well.
> 
> I vote against any acronyms that are not very well known.  Even knowing
> that it's supposed to be "digital temperature <something>", I can't
> figure out what the <something> is.  Not having the context that it
> relates to temperature, I wouldn't have a clue what "dtt" is.
> 
> hwmon is concise and fairly obvious, and unlike "temp" could be
> meaningfully used with chips that also monitor voltages, fan speeds, etc.
> 
> -Scott

Uh, thanks Scott. Now we got it. I am fully with you and my "V2" patch
should make everybody happy.

So, let's apply this patch.

Matthias
