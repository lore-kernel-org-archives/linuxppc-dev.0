Return-Path: <mgroeger@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [62.8.134.5])
	by ozlabs.org (Postfix) with ESMTP id 957D3682C5
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Sep 2005 20:20:48 +1000 (EST)
Date: Fri, 16 Sep 2005 11:51:57 +0200 (CEST)
From: Marius Groeger <mgroeger@sysgo.com>
Sender: mag@sysgo.com
To: Rita Carvalho <ritac_c@hotmail.com>
In-Reply-To: <BAY7-F9CCE196E3FF0097799A069E910@phx.gbl>
Message-ID: <Pine.LNX.4.63.0509161149410.8484@mag.sysgo.com>
References: <BAY7-F9CCE196E3FF0097799A069E910@phx.gbl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Java on PowerPC 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 16 Sep 2005, Rita Carvalho wrote:

> I am trying use IBMJava2-SDK-142.ppc.tgz in a PowerPc 440 GX with 
> Montavista. When I try the command ./java - version the error 
> Illegal instruction (core dumped) occurs.

Just a guess: have you turned on FPU emulation in the kernel 
configuration?

Regards,
Marius

-- 
Marius Groeger <mgroeger@sysgo.com>
SYSGO AG                      Embedded and Real-Time Software
Voice: +49 6136 9948 0                  FAX: +49 6136 9948 10
www.sysgo.com | www.elinos.com | www.osek.de | www.pikeos.com
