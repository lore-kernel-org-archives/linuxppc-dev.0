Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C8631B7082
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Sep 2009 19:34:22 +1000 (EST)
In-Reply-To: <1253494142-26821-1-git-send-email-paul.gortmaker@windriver.com>
References: <1253494142-26821-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8549256E-05F8-4990-866F-EB73C048E462@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] sbc8548: fixup of PCI-e related DTS fields
Date: Mon, 21 Sep 2009 11:34:38 +0200
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -				  0x0 0x08000000>;
> +				  0x0 0x0800000>;

You might want to write that as 0x00800000, otherwise people
will think it says 128M still :-)


Segher
