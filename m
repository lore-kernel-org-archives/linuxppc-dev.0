Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Carl Love <cel@us.ibm.com>
Subject: Re: [PATCH] CELL PPU Oprofile cleanup patch 
In-reply-to: <1170360615.5204.18.camel@dyn9047021078.beaverton.ibm.com> 
References: <1170360615.5204.18.camel@dyn9047021078.beaverton.ibm.com>
Date: Fri, 02 Feb 2007 09:52:28 +1100
Message-ID: <10720.1170370348@neuling.org>
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

Carl,

> +#define NUM_TRACE_BUS_WORDS 4
> +#define NUM_INPUT_BUS_WORDS 2

<snip>

> -	for (i = 0; i < 4; i++)
> +	for (i = 0; i < NUM_INPUT_BUS_WORDS; i++)
>  		trace_bus[i] = 0xff;
>  
> -	for (i = 0; i < 2; i++)
> +	for (i = 0; i < NUM_INPUT_BUS_WORDS; i++)
>  		input_bus[i] = 0xff;

The first loop looks like a bug...   Shouldn't it be NUM_TRACE_BUS_WORDS?

Mikey
