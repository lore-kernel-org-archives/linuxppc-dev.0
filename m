Return-Path: <aris@cathedrallabs.org>
Received: from panda.sul.com.br (panda.sul.com.br [200.219.150.4])
	by ozlabs.org (Postfix) with ESMTP id 6E7D967F30
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  7 Aug 2005 09:42:47 +1000 (EST)
Date: Sat, 6 Aug 2005 20:42:44 -0300
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-ID: <20050806234244.GB5210@cathedrallabs.org>
References: <20050806180353.GW5210@cathedrallabs.org>
	<20050806232701.GD1099@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050806232701.GD1099@dmt.cnet>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] 8xx: add cpm_get_cpmp()
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> It already is exported, declared as
> 
> commproc.h:extern       cpm8xx_t        *cpmp;          /* Pointer to comm processor */
> 
> 
> and many drivers use the pointer directly.
> 
> arch/ppc/8260_io/ drivers also use the same convention.
> 
> Not sure I see much advantage in changing it?
but not with EXPORT_SYMBOL(). I noticed this while compiling i2c stuff
as module. also, I think it's better add a function to do this instead
doing EXPORT_SYMBOL() in a variable.
what you think?

-- 
Aristeu
