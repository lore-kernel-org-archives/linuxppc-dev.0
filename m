Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7B254DE084
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 08:20:24 +1000 (EST)
Subject: Re: [PATCH 3/3] atyfb: Fix 64 bits resources on 32 bits archs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
In-Reply-To: <480E07BC.3050107@ru.mvista.com>
References: <20080422012726.42775DE2A3@ozlabs.org>
	<480E07BC.3050107@ru.mvista.com>
Content-Type: text/plain
Date: Wed, 23 Apr 2008 08:20:06 +1000
Message-Id: <1208902806.9640.136.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-fbdev-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, adaplas@gmail.com
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2008-04-22 at 19:43 +0400, Sergei Shtylyov wrote:
>     Not sure what that change gives us -- this function mostly treats 'addr' 
> as unsigned long (casting it to char/void *), ot compares it to 'unsigned 
> long' 'base' variable -- which should be made 'resource_size_t' in its turn 
> being assigned resource's start value.  So, this part of patch looks incomplete
> (and yet I'm not sure if SPARC really needs all that)...

I just wanted to make sure both setup functions has the same prototype. 

I think sparc doesn't need fixing in there.

Ben.
