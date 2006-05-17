Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3E504679F3
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 07:42:03 +1000 (EST)
Subject: Re: [Alsa-devel] [RFC] alsa integer control ranges
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <s5hd5ec4yn7.wl%tiwai@suse.de>
References: <1147780945.29795.110.camel@johannes>
	<s5h7j4m40kf.wl%tiwai@suse.de>
	<1147817023.6753.5.camel@localhost.localdomain>
	<s5hy7x10y5t.wl%tiwai@suse.de> <1147868218.15507.4.camel@johannes>
	<s5hd5ec4yn7.wl%tiwai@suse.de>
Content-Type: text/plain
Date: Thu, 18 May 2006 07:41:52 +1000
Message-Id: <1147902112.10703.2.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	ALSA development <alsa-devel@alsa-project.org>,
	Benjamin Berg <benjamin@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-05-17 at 14:35 +0200, Takashi Iwai wrote:

> The question is where to implement a huge table or a complex
> conversion function -- whether in the driver or in alsa-lib.

The lib of course

Ben.
