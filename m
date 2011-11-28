Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 135001007D1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2011 07:40:20 +1100 (EST)
Message-ID: <1322512810.23348.46.camel@pasglop>
Subject: Re: [PATCH] powerpc: Decode correct MSR bits in oops output
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Date: Tue, 29 Nov 2011 07:40:10 +1100
In-Reply-To: <F744714B-0527-415C-92BE-A5CB678F1C29@kernel.crashing.org>
References: <20111125163557.5a464006@kryten>
 <F744714B-0527-415C-92BE-A5CB678F1C29@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-11-28 at 10:04 -0600, Kumar Gala wrote:

> > +#ifndef CONFIG_BOOKE
> > +	{MSR_RI,	"RI"},
> 
> We have 'RI' on some BOOKE so lets allow for it to be decoded
> 
> > +	{MSR_LE,	"LE"},
> > +#endif
> > 	{0,		NULL}
> > };
> 
> Since you're fixing this can you add the following for CONFIG_BOOKE:
> 
> MSR_GS, MSR_UCLE, MSR_PMM, MSR_CM

Please send a followup patch.

Cheers,
Ben.
