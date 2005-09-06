Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8E62868113
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Sep 2005 12:38:18 +1000 (EST)
Date: Mon, 5 Sep 2005 19:38:16 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: viro@ZenIV.linux.org.uk
Message-ID: <20050906023816.GB5512@gate.ebshome.net>
References: <20050906004423.GO5155@ZenIV.linux.org.uk>
	<20050906021535.GA5512@gate.ebshome.net>
	<20050906022733.GU5155@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050906022733.GU5155@ZenIV.linux.org.uk>
Cc: linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] missed s/u32/pm_message_t/ in arch/ppc/syslib/ocp.c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 06, 2005 at 03:27:33AM +0100, viro@ZenIV.linux.org.uk wrote:
> On Mon, Sep 05, 2005 at 07:15:35PM -0700, Eugene Surovegin wrote:
>  
> > Identical fix is already in -mm
> 
> Then it really should go upstream; obvious fixes like that are not
> something that needs filtration...

Well, it's not up to me, really - I just follow our usual patch 
submit procedure (i.e. send everything to Andrew). However, patch was 
sent today in the morning (PDT), so I think Andrew will forward it to 
Linus soon.

-- 
Eugene
