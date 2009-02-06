Return-Path: <srostedt@redhat.com>
Received: from mx2.redhat.com (mx2.redhat.com [66.187.237.31])
	by ozlabs.org (Postfix) with ESMTP id D2A1EDDE9E
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Feb 2009 13:42:25 +1100 (EST)
Subject: Re: ftrace compile error with 32 bit PPC with mainline
From: Steven Rostedt <srostedt@redhat.com>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <1307.1233887821@neuling.org>
References: <1307.1233887821@neuling.org>
Content-Type: text/plain
Date: Thu, 05 Feb 2009 21:42:18 -0500
Message-Id: <1233888138.16878.48.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Fri, 2009-02-06 at 13:37 +1100, Michael Neuling wrote:

> # CONFIG_MODULES is not set


Those are module references. I never tested with modules turned off.
I'll write up a patch tonight.

Thanks,

-- Steve
