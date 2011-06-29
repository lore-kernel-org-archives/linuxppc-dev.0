Return-Path: <diggskevin38@gmail.com>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2DED7B6F57
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Jun 2011 04:25:13 +1000 (EST)
Received: by vxb40 with SMTP id 40so1194407vxb.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Jun 2011 11:25:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1309337670.14501.69.camel@pasglop>
References: <1308316207-9075-1-git-send-email-dbaryshkov@gmail.com>
	<1308316207-9075-2-git-send-email-dbaryshkov@gmail.com>
	<1309318110.32158.520.camel@pasglop>
	<BANLkTimJD3U1kRkDKVomGVriykwqLBQasA@mail.gmail.com>
	<1309337670.14501.69.camel@pasglop>
Date: Wed, 29 Jun 2011 13:25:10 -0500
Message-ID: <BANLkTikxO+EFo9CCmnkbHmjBXqK-4wQf7w@mail.gmail.com>
Subject: Re: [PATCH 2/2] Add cpufreq driver for Momentum Maple boards
From: kevin diggs <diggskevin38@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	Dave Jones <davej@redhat.com>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.ozlabs.org, cpufreq@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Try this one more time ...

On Wed, Jun 29, 2011 at 3:54 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2011-06-29 at 12:40 +0400, Dmitry Eremin-Solenikov wrote:
>
> If you feel like it :-) The powermac one has quite a bit more plumbing
> for voltage control etc... but it does make sense in the long run.
>
On my G5 (PowerMac7,3?), a dual 970FX @ 2.5G, I don't think the
voltage scaling works correctly. If someone else with one of these
(preferably someone who is NOT swamped (and named Ben)) could run some
experiments. I would like to know whether the G5 I bought on ebay is
some "FrankenG5" and the others actually work correctly.

To summarize, if I disable frequency scaling and look at the cpu core
voltages it runs at the LOW voltage at full (i.e. 2.5 GHz) speed. With
frequency scaling enabled, it runs the low speed at the same voltage
it runs at 2.5 GHz without frequency scaling enabled. At the full
speed it switches to a higher voltage. It WILL overheat if allowed to
'do stuff'. Temps above 110 are observed for cpu 1 (the second cpu in
the serial (i.e. cpu 1 is heated by cpu 0) cooling setup - DUH!!!).
The two voltages are like ~1.23 and ~1.35.

Back when this beast had MacOS X, I think it exhibited similar
behavior based on the fan noise.

kevin
