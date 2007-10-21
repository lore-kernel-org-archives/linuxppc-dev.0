Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4B0A6DDDE6
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Oct 2007 15:30:56 +1000 (EST)
In-Reply-To: <E1Iivsg-00078a-Vp@jdl.com>
References: <E1Iivsg-00078a-Vp@jdl.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <20d6133a9294d4f06a7e78ca627ec4f3@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 4/4] DTC: Begin the path to sane literals and expressions.
Date: Sun, 21 Oct 2007 07:30:45 +0200
To: Jon Loeliger <jdl@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Property names have been limited to start with
> characters from the set [a-zA-Z,._#?].  That is, the
> digits and the expression symbols have been removed.

This cannot work; many property names start with a digit,
for example.


Segher
