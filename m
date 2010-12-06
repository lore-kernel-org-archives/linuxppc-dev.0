Return-Path: <diggskevin38@gmail.com>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) by ozlabs.org (Postfix) with ESMTP id 16CEDB6EE8
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Dec 2010 05:25:51 +1100 (EST)
Received: by iwn2 with SMTP id 2so40267iwn.15
	for <linuxppc-dev@ozlabs.org>; Mon, 06 Dec 2010 10:25:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1291561537-1943-1-git-send-email-maz@misterjones.org>
References: <1291561537-1943-1-git-send-email-maz@misterjones.org>
Date: Mon, 6 Dec 2010 12:25:49 -0600
Message-ID: <AANLkTikyV0c-Djgf0xzeB2ZnJFSCi4vZue_7djcEa8PE@mail.gmail.com>
Subject: Re: [PATCH] Make auto-loading of therm_pm72 possible
From: kevin diggs <diggskevin38@gmail.com>
To: Marc Zyngier <maz@misterjones.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On a sort of related issue, if anyone out there has a PowerMac7,3
(dual 2.5 GHz 970Fx, PCI-X), I would appreciate it if you could do me
a favor.

I think this therm_pm72 thing creates the sysfs temperature and
voltage attributes for the cpus. I noticed on my machine that if I use
the cpufreq driver for this thing the frequencies were like 2.0 and
2.5. The problem is that the cpu voltages were something like 1.25 and
1.37 respectively. At 1.37 and 2.5 GHz, cpu 1 would zoom to 110+ under
load.

When I finally managed to get a compiler built that could build a
kernel past 2.6.28, I removed the cpufreq driver. Now this thing runs
at 2.5 GHz all the time. Under load cpu1 tops out at like 74 ish. I
eventually noticed that the voltage was 1.25. Huh? I thought this
voltage scaling business used the high voltage for the high frequency.
How can this thing be running at its high speed at the lower
voltage???

Can someone please confirm this behavior on a different 7,3? I did get
this thing off of ebay and might have myself a franken G5?

Thanks!

kevin

P.S.:  I also don't get the 2.0 GHz low speed? I thought with the FX
the speed would be 2.5 / 2 or 1.25? Does this beast NOT use the FX's
frequency scaling capabilities?
