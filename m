Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6D36267B61
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Jul 2006 04:53:45 +1000 (EST)
In-Reply-To: <1154112142.29826.297.camel@goblue>
References: <1154024154.29826.229.camel@goblue>
	<1154062599.21801.40.camel@localhost.localdomain>
	<802085A1-AA37-4787-A2D6-B619C6BE7AB4@kernel.crashing.org>
	<1154112142.29826.297.camel@goblue>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2D613078-5EE1-4C26-AABB-EF023B091E96@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH][0/2] RTAS MSI
Date: Fri, 28 Jul 2006 20:53:32 +0200
To: Jake Moilanen <moilanen@austin.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Sorry, I was less-than-clear.  I was going to use this same framework
> for MSI-X, and I was saying that it is not being correctly handled at
> this point.

Well it's _correct_ -- pci_enable_msix() always returns failure, that's
fine from a correctness perspective (although suboptimal from a  
performance
or functionality perspective, heh).


Segher
