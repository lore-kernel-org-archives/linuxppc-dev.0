Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 618C8DDF7B
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 19:41:33 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l5J9fNBo014870
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 02:41:23 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l5J9fMo8013079
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 04:41:22 -0500 (CDT)
Subject: Re: [PATCH 1/2]: Document the global utilities node define and example
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <b653522c06e6053167988bb8bcf3a868@kernel.crashing.org>
References: <1182237558.3269.14.camel@localhost.localdomain>
	<b653522c06e6053167988bb8bcf3a868@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1182246060.3878.1.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 19 Jun 2007 17:41:00 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-06-19 at 16:49, Segher Boessenkool wrote:
> > Document the global utilities node define and example.
> > Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> 
> Acked-by: Segher Boessenkool <segher@kernel.crashing.org>
> 
> Thanks for documenting this stuff.  One nit though...
> 
> > +     global-utilities@e0000 {        /* global utilities reg */
> 
> s/reg/block/ .  It's not a single 32768 bit register I'm
> sure (how would you access it?!)  :-)
I access it by a 32768 bit wide bus -:)!
Roy
