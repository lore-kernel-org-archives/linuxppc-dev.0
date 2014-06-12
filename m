Return-Path: <linux@roeck-us.net>
Received: from mail.active-venture.com (mail.active-venture.com
 [67.228.131.205])
 by lists.ozlabs.org (Postfix) with ESMTP id 6CF501A055E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jun 2014 08:18:05 +1000 (EST)
Message-ID: <539A2714.7060508@roeck-us.net>
Date: Thu, 12 Jun 2014 15:17:56 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: powerpc/ppc64: Allow allmodconfig to build (finally !)
References: <1399874254.17624.85.camel@pasglop>	
 <20140612122644.GA17249@roeck-us.net> <1402610268.14780.85.camel@pasglop>
In-Reply-To: <1402610268.14780.85.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/12/2014 02:57 PM, Benjamin Herrenschmidt wrote:
> On Thu, 2014-06-12 at 05:26 -0700, Guenter Roeck wrote:
>> what happened with this patch ?
>
> Well it breaks with that binutils version of yours ... I'm trying to fix
> it in a better way but it's a mess... still working on it.
>

I updated my binutils since then, though, and the other problem I encountered
(with the changed ABI) has been fixed. As it is, I'd prefer to have the patch
applied, but I can understand if you don't want to apply it in case others
hit the problem I had.

Guenter
