Return-Path: <edfuchs@uni-kassel.de>
Received: from hrz-ws41.hrz.uni-kassel.de (smtp.hrz.uni-kassel.de
	[141.51.12.231]) by ozlabs.org (Postfix) with ESMTP id DDF6BDDE1D
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 21:15:51 +1100 (EST)
Received: from ws-87.localnet (rs-pc1.rs.eecs.uni-kassel.de [141.51.112.154])
	by hrz-ws41.hrz.uni-kassel.de (8.14.0/8.14.0) with ESMTP id
	n2VAFhTf008021
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 12:15:43 +0200
From: Eduard Fuchs <edfuchs@uni-kassel.de>
To: linuxppc-dev@ozlabs.org
Subject: 8641D with linux 2.6.29 did'n show second cpu
Date: Tue, 31 Mar 2009 12:15:55 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200903311215.55237.edfuchs@uni-kassel.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I'm testing the evaluation board from freescale (MPC8641DHPCN) with the latest  
linux kernel (2.6.29) and the second core seems disabled. CONFIG_SPM is 
enabled but the /proc/cpuinfo shows only one cpu. With original 2.6.27 kernel 
both cpu cores appears in /proc/cpuinfo.

Has anyone an idea how can i enable the second core?

Best regards.

Eduard Fuchs
