Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 933EB679E1
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Mar 2006 07:40:08 +1100 (EST)
Date: Fri, 3 Mar 2006 21:40:01 +0100
From: Olaf Hering <olh@suse.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] force stackpointer alignment in 64bit kernel
Message-ID: <20060303204001.GA8366@suse.de>
References: <20060303135717.GA5707@suse.de> <20060303165253.GA6494@suse.de>
	<20060303191633.GA7792@suse.de>
	<3E10742C-61F9-417C-A191-C0C8C46A4529@kernel.crashing.org>
	<20060303200920.GA8177@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20060303200920.GA8177@suse.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Fri, Mar 03, Olaf Hering wrote:

> So the magic word is yaboot.

sp was 0x0023e6b4 when entering zImage.

yaboot_start has 64 bytes
yaboot_main has 304 bytes

This would mean the stackpointer for yaboot was 0x0023e824.
Will check on Monday.
