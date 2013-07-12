Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 41C5C2C0313
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jul 2013 09:03:54 +1000 (EST)
Message-ID: <1373670225.19894.211.camel@pasglop>
Subject: Re: error compiling ptrace in current mainline git
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chris Friesen <cbf123@mail.usask.ca>
Date: Sat, 13 Jul 2013 09:03:45 +1000
In-Reply-To: <51E02E7D.5050304@mail.usask.ca>
References: <51E02E7D.5050304@mail.usask.ca>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-07-12 at 10:27 -0600, Chris Friesen wrote:
> Hi all,
> 
> I'm trying to build current mainline git with gcc version 4.4.1 as a 
> cross compiler and I'm getting the following:
> 
> 
>    CC      arch/powerpc/kernel/ptrace.o
> {standard input}: Assembler messages:
> {standard input}:1619: Error: junk at end of line: `1'
> {standard input}:2074: Error: junk at end of line: `1'
> {standard input}:2742: Error: junk at end of line: `1'
> {standard input}:2855: Error: junk at end of line: `1'
> {standard input}:2943: Error: junk at end of line: `1'
> {standard input}:4699: Error: junk at end of line: `1'
> {standard input}:4794: Error: junk at end of line: `1'
> {standard input}:4915: Error: junk at end of line: `1'
> {standard input}:4985: Error: junk at end of line: `1'
> {standard input}:5087: Error: junk at end of line: `1'
> make[2]: *** [arch/powerpc/kernel/ptrace.o] Error 1
> make[1]: *** [arch/powerpc/kernel] Error 2
> make: *** [sub-make] Error 2
> 
> 
> Any ideas on how to deal with this?  Is this a code error or a compiler 
> error?

Can you send the .s and .i files ? Also you can try with newer compilers
(there are some cross compilers on kernel.org)

Cheers,
Ben.
