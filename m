Return-Path: <paulus@ozlabs.org>
Date: Tue, 31 Aug 2010 14:37:07 +1000
From: Paul Mackerras <paulus@samba.org>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH] powerpc: mtmsrd not defined
Message-ID: <20100831043707.GA19547@drongo>
References: <20100822180958.6305f5b1@lappy.seanm.ca>
	<1282516494.22370.440.camel@pasglop>
	<20100822184844.37c30d5e@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100822184844.37c30d5e@lappy.seanm.ca>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Aug 22, 2010 at 06:48:44PM -0400, Sean MacLennan wrote:

> Replace the BOOK3S_64 specific mtmsrd with the generic MTMSRD macro.
> 
> Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>

Acked-by: Paul Mackerras <paulus@samba.org>
