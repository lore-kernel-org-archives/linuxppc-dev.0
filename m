Return-Path: <Kallol_Biswas@pmc-sierra.com>
Received: from mother.pmc-sierra.bc.ca (mother.pmc-sierra.com [216.241.224.12])
	by ozlabs.org (Postfix) with SMTP id CB3CB67A75
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Jun 2006 11:02:23 +1000 (EST)
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca
	(bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by ogyruan.pmc-sierra.bc.ca (8.13.3/8.12.7) with ESMTP id
	k5212LDc024670
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Jun 2006 18:02:21 -0700
Message-ID: <478F19F21671F04298A2116393EEC3D5274040@sjc1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
From: Kallol Biswas <Kallol_Biswas@pmc-sierra.com>
To: External List <linuxppc-dev@ozlabs.org>
Subject: RE: How to find out what a process has been doing on a PPC-440 sy stem
Date: Thu, 1 Jun 2006 18:02:16 -0700 
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There is a tsk->thread.ksp (kernel stack pointer) but tsk->thread.regs is null. Next job is to get the register values from the ksp. If anyone has done it before it will save me some time.

-----Original Message-----
From: Kallol Biswas 
Sent: Thursday, June 01, 2006 5:47 PM
To: Kallol Biswas; External List
Subject: RE: How to find out what a process has been doing on a PPC-440 system

I think reading the .*switch() macros/functions we can get the answers.

-----Original Message-----
From: linuxppc-dev-bounces+biswaska=pmc-sierra.com@ozlabs.org [mailto:linuxppc-dev-bounces+biswaska=pmc-sierra.com@ozlabs.org] On Behalf Of Kallol Biswas
Sent: Thursday, June 01, 2006 5:36 PM
To: External List
Subject: How to find out what a process has been doing on a PPC-440 system

Hi,
   I have a list of processes running in a linux system (2.6.11 kernel).
One of the processes invokes send() system call and does not return.
The command "ps" shows that the process is in "RUNNING" state. With an ICE
I could dump each process structures and all the fields, but can't find a way to get the stack trace for each process. Not sure how contexts are saved on ppc-4xx kernel. It seems that they are saved in kernel stack. How do we
get the top of the stack from the task_struct pointers? How to find out
where in kernel send() blocks (not sleeping/scheduled)?

Kallol


_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
