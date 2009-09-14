Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 89188B6F1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Sep 2009 07:47:38 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 1EF1CDDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2009 07:47:37 +1000 (EST)
Date: Tue, 15 Sep 2009 01:47:36 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v3 2/5] powerpc/85xx/86xx: Add suspend/resume support
Message-ID: <20090914214736.GA13766@oksana.dev.rtsoft.ru>
References: <20090830193625.GA14693@oksana.dev.rtsoft.ru>
	<20090830193718.GB17519@oksana.dev.rtsoft.ru>
	<20090914172811.GA9074@b07421-ec1.am.freescale.net>
	<20090914202017.GA14428@oksana.dev.rtsoft.ru>
	<4AAEAB56.1050609@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4AAEAB56.1050609@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 14, 2009 at 03:45:10PM -0500, Scott Wood wrote:
[...]
> >You can't request the firmware in the qe driver's ->suspend()
> >routine necause the firmware may be on e.g. NFS filesystem or USB
> >stick (implies having QE Ethernet or QE USB fully functional).
> 
> Is there any way for software to read out the current firmware from
> the device, or is it write-only?

Hm, I didn't look into iram stuff that much, but seemingly I can
read it back and save. In the end, it's just a ram that we access
in a weird way... Let me try it.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
