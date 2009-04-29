Return-Path: <benjamin.zores@alcatel-lucent.fr>
Received: from smail2.alcatel.fr (smail2.alcatel.fr [62.23.212.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smail.alcatel.fr", Issuer "smail.alcatel.fr" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 96E28DDEF7
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 20:07:53 +1000 (EST)
Received: from bsf.alcatel.fr (mail205.sxb.bsf.alcatel.fr [155.132.205.115])
	by smail2.alcatel.fr (8.13.8/8.13.8/ICT) with ESMTP id n3T9jKsD027892
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 11:45:21 +0200
Received: from mail (mail-bsf-alcatel-fr.sxb.bsf.alcatel.fr [155.132.205.91])
	by bsf.alcatel.fr (8.8.8p2+Sun/8.9.3) with ESMTP id LAA28628
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 11:45:20 +0200 (MET DST)
Received: from [172.25.51.39] (frilln0l014001.emea.lucent.com [172.25.51.39])
	by mail (8.8.8p2+Sun/) with ESMTP id LAA28622
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 11:45:20 +0200 (MET DST)
Message-ID: <49F821B0.6030706@alcatel-lucent.fr>
Date: Wed, 29 Apr 2009 11:45:20 +0200
From: Benjamin Zores <benjamin.zores@alcatel-lucent.fr>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: FSL Driver load issues with OF
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi there,

Since the progressive migration of some PPC drivers to use of_platform bus
(typically migrating OF parsing from fsl_soc.c to the device probe/init 
functions),
I'm experiencing driver load issues.

Actually, I'm not longer able to load of these drivers as the probe() 
function is never called.
Everything goes fine if I put code back to fsl_soc.c with the 
arch_initcall() command.

Example of drivers that do no longer load for me: gianfar, talitos ...
Is there something obvious that I've missed ?

Ben
