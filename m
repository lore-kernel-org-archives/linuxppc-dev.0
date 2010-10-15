Return-Path: <linasvepstas@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by ozlabs.org (Postfix) with ESMTP id 5A6611007D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Oct 2010 12:47:24 +1100 (EST)
Received: by vws17 with SMTP id 17so173431vws.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Oct 2010 18:47:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1287078495-11722-1-git-send-email-nacc@us.ibm.com>
References: <1287078495-11722-1-git-send-email-nacc@us.ibm.com>
From: Linas Vepstas <linasvepstas@gmail.com>
Date: Thu, 14 Oct 2010 20:47:01 -0500
Message-ID: <AANLkTi=9OBaAj8QkwjwbgmUj8_XK7NFwOA9dv73Tk=hD@mail.gmail.com>
Subject: Re: [RFC PATCH] ppc: don't override CONFIG_PPC_PSERIES_DEBUG
To: Nishanth Aravamudan <nacc@us.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Michael Neuling <mikey@neuling.org>, Frans Pop <elendil@planet.nl>,
	linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
	linuxppc-dev@lists.ozlabs.org
Reply-To: linasvepstas@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 14 October 2010 12:48, Nishanth Aravamudan <nacc@us.ibm.com> wrote:
> These files undef DEBUG, but I think they were added before the ability
> to control this from Kconfig.

Right.

> It's really annoying to only get some of
> the debug messages!

I don't get the big picture.  Will there be some CONFIG_DEBUG_EEH in Kconfig?
or just some option to turn on DEBUG for all powerpc-related files?

Or maybe I am demonstrating my utter ignorance of some new whiz-bang
Kconfig technology?

Anyway, I see no harm in the EEH portion of the patch.

--linas
