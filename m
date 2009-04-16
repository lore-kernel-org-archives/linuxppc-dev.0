Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B9EA3DDEF7
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Apr 2009 17:53:57 +1000 (EST)
Date: Thu, 16 Apr 2009 09:53:39 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] AOA: Convert onyx and tas codecs to new-style i2c  
	drivers
Message-ID: <20090416095339.5cd026a0@hyperion.delvare>
In-Reply-To: <s5h1vrv2t0t.wl%tiwai@suse.de>
References: <20090408150249.5a62a56c@hyperion.delvare>
	<1239205899.16477.32.camel@johannes.local>
	<20090408224858.04cb6dc4@hyperion.delvare>
	<1239263089.24548.30.camel@johannes.local>
	<20090409141945.116772e3@hyperion.delvare>
	<20090410170238.6cc3a420@hyperion.delvare>
	<20090414163741.2a98b5d6@hyperion.delvare>
	<s5h1vrv2t0t.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>,
	alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 14 Apr 2009 16:45:38 +0200, Takashi Iwai wrote:
> Johannes, please let me know if the patch works.  Then I'll merge them.

Note if it matters: the new I2C binding model my patch uses is only
available since kernel 2.6.26.

-- 
Jean Delvare
