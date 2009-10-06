Return-Path: <hs@denx.de>
Received: from b.relay.invitel.net (b.relay.invitel.net [62.77.203.4])
	by ozlabs.org (Postfix) with ESMTP id B4A27B7B84
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Oct 2009 16:29:13 +1100 (EST)
Received: from mail.invitel.hu (mail.invitel.hu [213.163.59.4])
	by b.relay.invitel.net (Invitel Core SMTP Transmitter) with ESMTP id
	66D5031A6BB
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Oct 2009 07:29:10 +0200 (CEST)
Received: from [192.168.1.6] ([87.97.89.118])
	by mail.invitel.hu (Invitel Messaging Server)
	with ESMTPA id <0KR200KYLV8JBI40@invitel.hu> for
	linuxppc-dev@ozlabs.org; Tue, 06 Oct 2009 07:29:10 +0200 (CEST)
Date: Tue, 06 Oct 2009 07:19:25 +0200
From: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH v2] mpc5200: support for the MAN mpc5200 based board uc101
In-reply-to: <fa686aa40910050646p168c2bbfi4b432778827102c9@mail.gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Message-id: <4ACAD35D.4060904@denx.de>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
References: <4AADF93C.3030604@denx.de> <20090914080322.GA3164@pengutronix.de>
	<fa686aa40909140745u2cf1dba7q8ae2af53c87bd216@mail.gmail.com>
	<4AC9A463.1080903@denx.de> <20091005095340.GA3890@pengutronix.de>
	<4AC9C6AA.6060009@denx.de>
	<fa686aa40910050646p168c2bbfi4b432778827102c9@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Grant,

Grant Likely wrote:
> On Mon, Oct 5, 2009 at 4:12 AM, Heiko Schocher <hs@denx.de> wrote:
>> Wolfram Sang wrote:
>>> Is this an official binding? I also did an gpio-watchdog a while ago and there
>>> were some issues with the binding, IIRC. Would be nice if this has been solved
>>> meanwhile.
>> Oh, sorry, no. I remove it.
> 
> You don't need to remove it, but choose a compatible value within the
> board/manufacturer namespace.  ie. 'manroland,uc101-watchdog'.  You

Hmm.. currently I prefer to remove it, because it is not a uc101 special
wdt driver. When this wdt driver go in mainline, it is easy to readd it
to this board support.

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
