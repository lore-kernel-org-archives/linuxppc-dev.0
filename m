Return-Path: <srinivasa@in.ibm.com>
Received: from e23smtp04.au.ibm.com (E23SMTP04.au.ibm.com [202.81.18.173])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 30744DDDFF
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 19:06:58 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp04.au.ibm.com (8.13.1/8.13.1) with ESMTP id m6F961QD030412
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 19:06:01 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6F96uqZ112712
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 19:06:56 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6F96tMj009550
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 19:06:56 +1000
From: Srinivasa D S <srinivasa@in.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [RFC] [PATCH] task_pt_regs for powerpc systems
Date: Tue, 15 Jul 2008 14:36:55 +0530
References: <200807071952.27427.srinivasa@in.ibm.com>
	<200807141401.26917.srinivasa@in.ibm.com>
	<1216026417.7549.270.camel@pasglop>
In-Reply-To: <1216026417.7549.270.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200807151436.55912.srinivasa@in.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 14 July 2008 02:36:57 pm Benjamin Herrenschmidt wrote:

> > Signed-off-by: Srinivasa DS <srinivasa@in.ibm.com>
>
> Can you send a cleanup patch against powerpc.git instead ?
>

Resending the patch against powerpc.git tree.


Signed-off-by: Srinivasa DS <srinivasa@in.ibm.com>


---
 include/asm-powerpc/processor.h |    2 ++
 1 file changed, 2 insertions(+)

Index: powerpc.git/include/asm-powerpc/processor.h
===================================================================
--- powerpc.git.orig/include/asm-powerpc/processor.h
+++ powerpc.git/include/asm-powerpc/processor.h
@@ -234,6 +234,8 @@ struct thread_struct {
 #define thread_saved_pc(tsk)    \
         ((tsk)->thread.regs? (tsk)->thread.regs->nip: 0)
 
+#define task_pt_regs(tsk)	((tsk)->thread.regs)
+
 unsigned long get_wchan(struct task_struct *p);
 
 #define KSTK_EIP(tsk)  ((tsk)->thread.regs? (tsk)->thread.regs->nip: 0)
