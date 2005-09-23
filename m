Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0796368399
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 24 Sep 2005 08:58:13 +1000 (EST)
Date: Fri, 23 Sep 2005 15:58:11 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Roland Dreier <rolandd@cisco.com>
Message-ID: <20050923225811.GB22816@gate.ebshome.net>
References: <2005922203.92drttvd27WS9dXk@cisco.com>
	<2005922203.UPGbNSgrHKasoXYq@cisco.com>
	<20050923102038.G21055@cox.net> <52y85n8kvg.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52y85n8kvg.fsf@cisco.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 2/4] [PPC32] Add 440SPe support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Sep 23, 2005 at 03:44:35PM -0700, Roland Dreier wrote:
> BTW, Eugene, you might want to do a 'git prune-packed' on your git
> tree.  It's pretty wasteful to clone your tree now, because you have a
> lot of individual objects that also appear in Linus's packs.

Yeah, I did this yesterday, so I guess your next pulls should be OK. 
You may need to do this on the cloned tree as well.

-- 
Eugene
