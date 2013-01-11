Return-Path: <R.Patil@mei-india.com>
Received: from antispam.messung.com (outbond.messung.com [210.212.173.45])
 by ozlabs.org (Postfix) with ESMTP id 3B1712C01FA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2013 18:36:33 +1100 (EST)
In-Reply-To: 
Subject: Interrupt handler not executed
From: R.Patil@mei-india.com
To: linuxppc-dev@lists.ozlabs.org
Message-ID: <OFFE4470AC.C2444613-ON65257AF0.0029CACD-65257AF0.0029CAD8@LocalDomain>
Date: Fri, 11 Jan 2013 13:06:29 +0530
Content-Type: text/plain;
	charset=ISO-8859-1
MIME-Version: 1.0
References: 
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

We are working on board based on Freescale MPC8313ERDB. We have ported linu=
x 3.0.46 kernel on it. In one of device driver written by us, we need to ta=
ke some action upon asserting IRQ0 interrupt. For this we have written inte=
rrupt handler which takes care of this. We are able register interrupt hand=
ler successfully with the help of 'request=5Firq'. We confirmed this by che=
cking respective entry in '/proc/interrupts'. We have also confirmed assert=
ion of interrupt line (IRQ0) on oscilloscope. The problem is, interrupt han=
dler does not execute upon asserting the interrupt line.    =20

Interesting part is, we have similar requirement in other drivers but for d=
ifferent interrupt lines. The interrupt handler for them executes successfu=
lly. What could be the possible reasons for this behaviour (not invoking IR=
Q0 interrupt handler)? If anybody could give a hint to solve or debug the p=
roblem?

Kind Regards,
Rahul PatilEmail Disclaimer:
  ---------------------------

This e-mail and any files transmitted with it are for the sole use of the i=
ntended recipient(s) and may contain confidential and  privileged informati=
on. Computer viruses can be transmitted via email.The recipient should chec=
k this email and any  attachments for the presence of viruses. The company =
accepts no liability for any damage caused by any virus transmitted by this=
 email.
