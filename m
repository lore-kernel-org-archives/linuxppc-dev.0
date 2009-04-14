Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 1A9E6DDF86
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Apr 2009 02:48:34 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] AOA: Convert onyx and tas codecs to new-style i2c drivers
References: <20090408150249.5a62a56c@hyperion.delvare>
	<1239205899.16477.32.camel@johannes.local>
	<20090408224858.04cb6dc4@hyperion.delvare>
	<1239263089.24548.30.camel@johannes.local>
	<20090409141945.116772e3@hyperion.delvare>
	<1239723613.24771.8.camel@johannes.local>
Date: Tue, 14 Apr 2009 18:48:28 +0200
In-Reply-To: <1239723613.24771.8.camel@johannes.local> (Johannes Berg's
	message of "Tue, 14 Apr 2009 17:40:13 +0200")
Message-ID: <m2ws9n18rn.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jean Delvare <khali@linux-fr.org>, Takashi Iwai <tiwai@suse.de>,
	alsa-devel@alsa-project.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Johannes Berg <johannes@sipsolutions.net> writes:

> So I went to test this, but for some reason aoa doesn't work for me at
> all, neither with nor without this patch.

That is already fixed by
<http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/driver-core.current/driver-core-fix-driver_match_device.patch>

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
