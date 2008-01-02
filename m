Return-Path: <roland@redhat.com>
Received: from QMTA08.emeryville.ca.mail.comcast.net
	(qmta08.emeryville.ca.mail.comcast.net [76.96.30.80])
	by ozlabs.org (Postfix) with ESMTP id 2FD6CDDEBD
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 09:13:02 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH -mm] compat_binfmt_elf Kconfig
In-Reply-To: Sam Ravnborg's message of  Wednesday,
	2 January 2008 22:53:11 +0100
	<20080102215311.GA12558@uranus.ravnborg.org>
References: <20071223183920.GA13976@elte.hu>
	<20071223211603.3FFB126F8E7@magilla.localdomain>
	<20071230163614.GB1384@elte.hu>
	<20080102044157.A5CC526F99F@magilla.localdomain>
	<20080102111431.GD14731@elte.hu>
	<20080102191030.GA11217@uranus.ravnborg.org>
	<20080102210831.9F80426F9A0@magilla.localdomain>
	<20080102215311.GA12558@uranus.ravnborg.org>
Message-Id: <20080102221228.C9D8D26F9A0@magilla.localdomain>
Date: Wed,  2 Jan 2008 14:12:28 -0800 (PST)
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have no opinions about the config symbol names.  Among the existing
precedents for internal/descriptionless symbols I find more not using the
HAVE_ prefix than those using it.  The patch versions I've sent now work
fine, fix the parallel build problem people were seeing, and AFAICT follow
the style of what's already in common use.  At this point, I think it would
be easiest just to keep them and have you send symbol-renaming patches
for any and all symbols of this sort that concern you as separate cleanups.


Thanks,
Roland
