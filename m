Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CC3E6DDDF6
	for <linuxppc-dev@ozlabs.org>; Mon,  5 May 2008 04:22:43 +1000 (EST)
Message-Id: <6C8AB345-2DA0-460D-B7C8-262463247DDE@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: sam@ravnborg.org
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: How to link a .o with all modules
Date: Sun, 4 May 2008 13:22:38 -0500
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	lkml List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sam,

We have a case in powerpc in which we want to link some library  
routines with all module objects.  The routines are intended for  
handling out-of-line function call register save/restore so having  
them as EXPORT_SYMBOL() is counter productive (we do also need to link  
the same "library" code into the kernel).

Any suggestions on how to handle this?

thanks

- k
