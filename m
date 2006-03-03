Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7E7C967A03
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Mar 2006 06:23:36 +1100 (EST)
Date: Fri, 3 Mar 2006 20:23:31 +0100
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@ozlabs.org, Paul Mackeras <paulus@samba.org>
Subject: Re: [PATCH] force stackpointer alignment in 64bit kernel
Message-ID: <20060303192331.GA7939@suse.de>
References: <20060303135717.GA5707@suse.de> <20060303165253.GA6494@suse.de>
	<20060303191633.GA7792@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20060303191633.GA7792@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Fri, Mar 03, Olaf Hering wrote:

> +	addi	r1,r1,16

Guess that should be -16 ...
