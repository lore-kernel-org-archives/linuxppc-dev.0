Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F080D689F9
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jan 2006 08:29:23 +1100 (EST)
Date: Fri, 20 Jan 2006 22:29:17 +0100
From: Olaf Hering <olh@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [Alsa-devel] RFC: OSS driver removal,
	a slightly different approach
Message-ID: <20060120212917.GA14405@suse.de>
References: <20060119174600.GT19398@stusta.de>
	<20060120115443.GA16582@palantir8>
	<20060120190415.GM19398@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20060120190415.GM19398@stusta.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Fri, Jan 20, Adrian Bunk wrote:

 
> Can someone from the ppc developers drop me a small note whether 
> SND_POWERMAC completely replaces DMASOUND_PMAC?

It doesnt. Some tumbler models work only after one plug/unplug cycle of
the headphone. early powerbooks report/handle the mute settings
incorrectly. there are likely more bugs.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
