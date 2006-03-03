Return-Path: <olh@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BE526679A6
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Mar 2006 04:24:49 +1100 (EST)
Date: Fri, 3 Mar 2006 18:24:40 +0100
From: Olaf Hering <olh@suse.de>
To: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
Subject: Re: alignment bugs in prom_init
Message-ID: <20060303172440.GA6691@suse.de>
References: <20060303135717.GA5707@suse.de>
	<44086B5E.60201@smiths-aerospace.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <44086B5E.60201@smiths-aerospace.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Fri, Mar 03, Jerry Van Baren wrote:

> Looks like you should use -malign-natural to make it do what you want it 

Same story.

c00000000040b924:       3b 01 00 78     addi    r24,r1,120
c00000000040b968:       57 08 00 38     rlwinm  r8,r24,0,0,28
c00000000040b984:       4b ff d6 01     bl      c000000000408f84 <.call_prom>
c00000000040b998:       80 01 00 78     lwz     r0,120(r1)

,28 is even worse.
