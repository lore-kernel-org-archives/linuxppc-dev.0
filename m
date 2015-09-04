Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D38F31A1E32
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Sep 2015 05:51:12 +1000 (AEST)
Date: Fri, 4 Sep 2015 13:31:14 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: christophe leroy <christophe.leroy@c-s.fr>
Cc: Scott Wood <scottwood@freescale.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/book3s32: Only select PPC_HAVE_PMU on e600
Message-ID: <20150904183114.GA30286@gate.crashing.org>
References: <20150903092704.2F4881A241D@localhost.localdomain>
 <20150904164349.GA10337@home.buserror.net> <55E9DC5B.4090506@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55E9DC5B.4090506@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 04, 2015 at 08:00:59PM +0200, christophe leroy wrote:
> >Plus, it's e300, not e600, that is the exception among 6xx-style cores.
> Is it ? I've been looking for special register SIAR (spr 955) in several 
> 6xx reference manuals.
> 82xx doesn't have it, 52xx and 512x don't have it.
> I found it only in the 86xx
> Which other family has it ?

7xx, 7xxx have it.  I don't think any 603 or 604 have it.


Segher
