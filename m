Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 16420DDFC5
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 16:25:10 +1100 (EST)
Subject: Re: [PATCH] powerpc: Add support for using doorbells for SMP IPI
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <10CBF092-BD35-4A99-B4E7-44AA43B731AA@kernel.crashing.org>
References: <1234482893-17712-1-git-send-email-galak@kernel.crashing.org>
	<1234493200.29851.79.camel@pasglop>
	<10CBF092-BD35-4A99-B4E7-44AA43B731AA@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 13 Feb 2009 16:25:04 +1100
Message-Id: <1234502704.26036.40.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> crit doorbell for xmon IPI sounds interesting.  However, I don't  
> following about use of external CRITs for IPIs.

Just a finger not following the brain :-) I meant for NMI's

Cheers,
Ben.
