Return-Path: <palves@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E27031A0034
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 09:57:21 +1000 (AEST)
Message-ID: <55CA8BDD.30708@redhat.com>
Date: Wed, 12 Aug 2015 00:57:17 +0100
From: Pedro Alves <palves@redhat.com>
MIME-Version: 1.0
To: Ran Shalit <ranshalit@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 gdb <gdb@sourceware.org>
Subject: Re: gdb with powerpc
References: <CAJ2oMhLr9aoZ258hm0-xuRuW5iksLMOgNOL=hQh6S4SteFNDeg@mail.gmail.com>
In-Reply-To: <CAJ2oMhLr9aoZ258hm0-xuRuW5iksLMOgNOL=hQh6S4SteFNDeg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/11/2015 05:50 PM, Ran Shalit wrote:
> Hello,
> 
> I would like to ask if anyone tried remote debugging with
> gdb/gdbserver on powerpc.
> I've tried to cross-compile gdb for powerpc, but I get into troubles.
> I am using the following compiler:
> powerpc-buildroot-linux-gnu-gcc (Buildroot 2014.11) 4.8.3
> 

> gcc -c -g -O2    -I. -I.././gdb -I.././gdb/config

Looks like you're using your host x86 gcc to build a ppc program.
That can't work.

> As an alternative, Is anyone familiar with binary package with
> gdb/gdbserver for powerpc used with x86 host ?

Please try following the instructions at:

 https://sourceware.org/gdb/wiki/BuildingCrossGDBandGDBserver

Thanks,
Pedro Alves
