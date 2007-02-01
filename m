Return-Path: <cel@us.ibm.com>
Subject: Re: [PATCH] CELL PPU Oprofile cleanup patch
From: Carl Love <cel@us.ibm.com>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <10720.1170370348@neuling.org>
References: <1170360615.5204.18.camel@dyn9047021078.beaverton.ibm.com>
	<10720.1170370348@neuling.org>
Content-Type: text/plain
Date: Thu, 01 Feb 2007 15:15:52 -0800
Message-Id: <1170371752.5204.20.camel@dyn9047021078.beaverton.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mikey:

Yes, that is an error.  Thanks for the catch.

          Carl Love

On Fri, 2007-02-02 at 09:52 +1100, Michael Neuling wrote:
> Carl,
> 
> > +#define NUM_TRACE_BUS_WORDS 4
> > +#define NUM_INPUT_BUS_WORDS 2
> 
> <snip>
> 
> > -     for (i = 0; i < 4; i++)
> > +     for (i = 0; i < NUM_INPUT_BUS_WORDS; i++)
> >               trace_bus[i] = 0xff;
> >  
> > -     for (i = 0; i < 2; i++)
> > +     for (i = 0; i < NUM_INPUT_BUS_WORDS; i++)
> >               input_bus[i] = 0xff;
> 
> The first loop looks like a bug...   Shouldn't it be
> NUM_TRACE_BUS_WORDS?
> 
> Mikey
