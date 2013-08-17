Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 670C72C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Aug 2013 08:05:30 +1000 (EST)
Message-ID: <1376777122.25016.9.camel@pasglop>
Subject: Re: Critical Interrupt Input
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Date: Sun, 18 Aug 2013 08:05:22 +1000
In-Reply-To: <DA804F98-B7E5-42C1-9D5C-8A8A63681EC0@kernel.crashing.org>
References: <4724f96e$5f998126$5fb2b995$@deltatau.com>
 <DA804F98-B7E5-42C1-9D5C-8A8A63681EC0@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, hbausley@deltatau.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-08-16 at 06:04 -0500, Kumar Gala wrote:
> The 44x low level code needs to handle exception stacks properly for
> this to work.  Since its possible to have a critical exception occur
> while in a normal exception level, you have to have proper saving of
> additional register state and a stack frame for the critical
> exception, etc.  I'm not sure if that was ever done for 44x.

Don't 44x and FSL BookE share the same macros ? I would think 44x does
indeed implement the same crit support as e500...

What does the crash look like ?

Ben.
