Return-Path: <g.jaeger@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [62.8.134.5])
	by ozlabs.org (Postfix) with ESMTP id 24CE467A07
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 30 May 2005 20:23:49 +1000 (EST)
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: linuxppc-embedded@ozlabs.org
Date: Mon, 30 May 2005 12:23:35 +0200
References: <DCEAAC0833DD314AB0B58112AD99B93B8593A1@ismail.innsys.innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B8593A1@ismail.innsys.innovsys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200505301223.35968.g.jaeger@sysgo.com>
Subject: Re: Cross compiler
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

On Thursday 26 May 2005 17:33, Rune Torgersen wrote:
> Anybody know how to set up a cross compiler for nptl support?
> 
> I'm trying to use crosstools to compile a gcc-3.4.3/glibc-2.3.4 for
> ppc-604 (actually for mpc826x) on i686.

which version of crosstools?

> It works if I make it with linuxthreads.
> If I do GLIBC_ADDON_OPTIONS==nptl ./my-ppc604_new.sh
> Then glibc configure fails with an error about needing a gcc with forced
> unwind support.
> 
> If I try to set up gcc options to enable threading, then GCC core
> compile fails with error that it cannot find pthread.h
> 
> Anybody know of a solution?

have you checked out:
http://www.wwwdotorg.org/writings/code/nptl_tool/nptl_tool.html

Gerhard

-- 
Gerhard Jaeger <gjaeger@sysgo.com>            
SYSGO AG                      Embedded and Real-Time Software
www.sysgo.com | www.elinos.com | www.pikeos.com | www.osek.de 
