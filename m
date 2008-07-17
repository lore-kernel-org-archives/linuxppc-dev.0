Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 2AE05DDF4D
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 07:32:38 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: 82xx performance
Date: Thu, 17 Jul 2008 23:32:17 +0200
References: <DCEAAC0833DD314AB0B58112AD99B93B04AE61BC@ismail.innsys.innovsys.com>
	<200807172143.57576.arnd@arndb.de>
	<DCEAAC0833DD314AB0B58112AD99B93B04B34E18@ismail.innsys.innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B04B34E18@ismail.innsys.innovsys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807172332.18030.arnd@arndb.de>
Cc: Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 17 July 2008, Rune Torgersen wrote:
> Arnd Bergmann wrote:
> > So again, nothing conclusive. I'm running out of ideas.
> 
> Is the syscall path different or the same on ppc and powerpc?
> Any differences in the task switching, irq handling or page fault
> handling?
> 

It's all different in suble ways, but those changes should only
show up in the system time accounting, not user time accounting.

One change that I would expect to show up in user space performance
is different TLB management, in a way that causes increased flushing
and reloading of page table entries. I don't have the slightest
idea if or in what ways that has changed. Maybe Ben has a clue
about this.

	Arnd <><
