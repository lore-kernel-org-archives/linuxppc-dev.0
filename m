Return-Path: <tartler@faui48a.informatik.uni-erlangen.de>
Received: from faui40.informatik.uni-erlangen.de
	(faui40.informatik.uni-erlangen.de [131.188.34.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D1BA31007E5
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jun 2010 17:34:52 +1000 (EST)
From: Reinhard Tartler <Reinhard.Tartler@informatik.uni-erlangen.de>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 0/5] Removing dead code
References: <cover.1275925219.git.siccegge@cs.fau.de>
	<1276195612.1556.279.camel@Joe-Laptop.home>
Date: Fri, 11 Jun 2010 09:26:02 +0200
In-Reply-To: <1276195612.1556.279.camel@Joe-Laptop.home> (Joe Perches's
	message of "Thu, 10 Jun 2010 11:46:52 -0700")
Message-ID: <rwutypado8l.fsf@faui48a.informatik.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Robert P. J. Day" <rpjday@crashcourse.ca>,
	vamos@i4.informatik.uni-erlangen.de, Christoph Egger <siccegge@cs.fau.de>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Joe Perches <joe@perches.com> writes:

> (cc's trimmed and rpjday added)
>
> On Wed, 2010-06-09 at 11:58 +0200, Christoph Egger wrote:
>> I've been running a check on the arch/powerpc sourcetree for
>> config Items not defined in Kconfig and found5 such chases.
>
> Are you aware of
> http://www.crashcourse.ca/wiki/index.php/Kernel_cleanup_scripts

Yes, we are. These scripts aim at a very similar goal.  However, we are
using a more sound approach that actually involves parsing CPP
statements and the kconfig language and checking the resulting
constraints with SAT solving tools.  This way, we get way more precise
results.

You can read about our approach in [1].

[1] http://portal.acm.org/citation.cfm?id=1629732

-- 
Reinhard Tartler                     Department of Computer Science IV
Martensstr 1, 91058 Erlangen Germany, University of Erlangen-Nuremberg
            http://www4.informatik.uni-erlangen.de/~tartler
