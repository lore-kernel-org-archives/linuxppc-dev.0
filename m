Return-Path: <cfriesen@nortel.com>
Received: from zcars04f.nortelnetworks.com (zcars04f.nortelnetworks.com
	[47.129.242.57]) by ozlabs.org (Postfix) with ESMTP id 5780767A06
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Jun 2005 07:40:08 +1000 (EST)
Message-ID: <42A765A1.2000000@nortel.com>
Date: Wed, 08 Jun 2005 15:39:45 -0600
From: Chris Friesen <cfriesen@nortel.com>
MIME-Version: 1.0
To: Hollis Blanchard <hollis@penguinppc.org>
References: <42A5B3E6.9030401@nortel.com>
	<4b474e026a1d6040f1ec24466d8ff6a8@kernel.crashing.org>
	<455acab93dd9ab20cbbc1cff400f84e3@penguinppc.org>
In-Reply-To: <455acab93dd9ab20cbbc1cff400f84e3@penguinppc.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Linux PPC Dev <linuxppc-dev@ozlabs.org>
Subject: Re: syntax for clobber list with inline assembly
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hollis Blanchard wrote:

> But it should be said that much better style is to let the compiler 
> choose registers for you, i.e. don't hardcode register numbers at all. 
> For example (well, it's contrived, but I hope you get the idea):

Certainly that would be the normal case.

In this particular case I'm writing some code to test whether my 
function to flush/clear the entire cache is properly working.

It uses self-modifying code, and I've got some instructions using r3 
hardcoded as hex.  Thus the specific use of r3.

Chris
