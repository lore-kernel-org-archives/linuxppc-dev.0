Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 961E4DEC15
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 01:20:38 +1000 (EST)
Message-Id: <73238BF6-DE3E-4082-8AFA-9B955E7960F8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Philippe De Muyter <phdm@macqel.be>
In-Reply-To: <20080409230626.GA2577@frolo.macqel>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] mpc8540 : Fix restart
Date: Mon, 14 Apr 2008 10:20:29 -0500
References: <20080409221256.GA927@frolo.macqel>
	<64B092F9-7790-4655-AA12-B9010D87D0A4@kernel.crashing.org>
	<20080409230626.GA2577@frolo.macqel>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>
> What do you propose then ? The ability to reboot without power-off is
> really needed for embedded targets.  And abort() from head_fsl.S   
> seems
> really close to reboot.

Boards should provide system logic mechanism that should be used.  The  
problem is abort() only resets the core.  The rest of the SoC wlll not  
be properly reset.

- k
