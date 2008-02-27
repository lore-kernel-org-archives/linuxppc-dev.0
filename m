Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 24417DDF2B
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2008 19:19:15 +1100 (EST)
Subject: Re: [PATCH 3/8] Remove unused pte_offset variable
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1204099860.6932.2.camel@concordia>
References: <4108415683edeb799fd4880a8dba3e9f27a34415.1204097262.git.michael@ellerman.id.au>
	<180c3c87682d05b1d58e50df77f99478f98d9b30.1204097262.git.michael@ellerman.id.au>
	<1204099491.15052.227.camel@pasglop>
	<1204099860.6932.2.camel@concordia>
Content-Type: text/plain
Date: Wed, 27 Feb 2008 19:18:49 +1100
Message-Id: <1204100329.15052.229.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-02-27 at 19:11 +1100, Michael Ellerman wrote:

> I'm pretty sure I tested it and it worked.
> 
> But I didn't actually change anything WRT the spider offset anyway, we
> still add it to it_offset just like we used to, it's just we don't put
> it in the window and then pull it out again.
> 
> The only thing that's changed is we now use offset (aka. base) in the
> tce routines in addition to pte_offset.

Ok. Should be fine then.

Ben.
