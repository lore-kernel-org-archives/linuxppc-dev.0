Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 9C52ADDE34
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Feb 2008 09:54:40 +1100 (EST)
Date: Thu, 31 Jan 2008 15:54:46 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Reminder: removal of arch/ppc
Message-ID: <20080131225446.GA9633@mag.az.mvista.com>
References: <E83C3B2F-0FC4-4248-B718-0C45B56E969A@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E83C3B2F-0FC4-4248-B718-0C45B56E969A@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jan 25, 2008 at 10:55:25AM -0600, Kumar Gala wrote:
> Just a reminder that the plan is to remove arch/ppc this summer (June  
> 2008).  The following boards still existing over in arch/ppc.  Some of  
> them have been ported over to arch/powerpc.  If you care about one of  
> these boards and its not ported speak up (it helps if you have access  
> to the board).  Also, if you know a given board is free to die of  
> bitrot let us know so we know not to worry about it:

I guess I'm just not a nice guy but I say let them die.  No need
to worry.  The code really isn't going anywhere -- git-checkout
v2.6.<pick your favorite version> and its back.

/me's $0.02.

Mark
