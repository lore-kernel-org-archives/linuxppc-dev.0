Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 08CBC679E0
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Apr 2006 02:00:41 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5CA113BC-1614-4551-87E5-6926E14C2225@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: DTC/dts modifications
Date: Sat, 29 Apr 2006 11:00:34 -0500
To: Jon Loeliger <jdl@freescale.com>
Cc: Jon Loeliger <jdl@jdl.com>,
	"linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

All,

What evilness would it be to change the use of '#' in the .dts format  
to some other character like '$' or '%'.  The problem is the use of  
'#' prevents use from using cpp which would make some aspects of  
building up .dts for boards far more useful.

We can easily provide a one line script to convert people's .dts to  
the new format.

- kumar
