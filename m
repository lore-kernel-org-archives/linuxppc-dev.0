Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E9CB62C0129
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 09:14:37 +1000 (EST)
Message-ID: <1374707665.6142.18.camel@pasglop>
Subject: Re: [PATCH] module: ppc64 module CRC relocation fix causes perf issues
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
Date: Thu, 25 Jul 2013 09:14:25 +1000
In-Reply-To: <20130725083427.56e36010@kryten>
References: <20130718140045.6794ecd5@kryten> <1374274770.5357.33@snotra>
 <20130725083427.56e36010@kryten>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Neil Horman <nhorman@tuxdriver.com>, Rusty Russell <rusty@rustcorp.com.au>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-07-25 at 08:34 +1000, Anton Blanchard wrote:
> > Apart from the annoying colors, is there anything specific I should
> > be looking for?  Some sort of error message, or output that actually
> > makes sense?
> 
> Thanks for testing! Ben, I think the patch is good to go.

Sent it yesterday to Linus, it's upstream already :-)

Cheers,
Ben.
