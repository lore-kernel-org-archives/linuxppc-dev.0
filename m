Return-Path: <benh@kernel.crashing.org>
Message-ID: <1427452587.20500.0.camel@kernel.crashing.org>
Subject: Re: [Skiboot] [v2, 1/3] powerpc/powernv: convert codes returned by
 OPAL calls
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 27 Mar 2015 21:36:27 +1100
In-Reply-To: <20150327095936.50A921400A0@ozlabs.org>
References: <20150327095936.50A921400A0@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: skiboot@lists.ozlabs.org,
 =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@fr.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-03-27 at 20:59 +1100, Michael Ellerman wrote:
> 
> Can you put it in opal.h and give it a better name, maybe
> opal_error_code() ?

Do we want it to be inlined all the time ? Feels more like something we
should have in opal.c

Also we only want to call it when we "forward" the error code up the
food chain, there are a number of cases where we look for specific OPAL
error codes.

Cheers,
Ben.
