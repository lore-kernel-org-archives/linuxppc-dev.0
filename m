Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao11.cox.net (fed1rmmtao11.cox.net [68.230.241.28])
	by ozlabs.org (Postfix) with ESMTP id 524542BDC5
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Sep 2004 09:15:47 +1000 (EST)
Date: Tue, 21 Sep 2004 16:15:42 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Message-ID: <20040921231542.GD16619@smtp.west.cox.net>
References: <414B6363.5060106@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <414B6363.5060106@nortelnetworks.com>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: support for revision C of the mcpn765?
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 17, 2004 at 04:21:23PM -0600, Chris Friesen wrote:

> 
> We've got revision C of the mcpn765 from Motorola.  The main difference 
> appears to be that it uses the 82c686 chip rather than the 586, requiring 
> some extra checking in mcpn765_init2().
> 
> Is there a patch already out there, or should I send one in?

Please post a patch vs a current 2.6 (and if you haven't already, read
Documentation/SubmittingPatches and read the Developer's Certificate of
Origin).  Thanks.

-- 
Tom Rini
http://gate.crashing.org/~trini/
