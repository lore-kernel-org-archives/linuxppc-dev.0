Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C7813DEB03
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 02:30:49 +1000 (EST)
In-Reply-To: <20080421143313.GB18008@polina.dev.rtsoft.ru>
References: <20080418190632.GA32204@polina.dev.rtsoft.ru>
	<20080418190959.GD4407@polina.dev.rtsoft.ru>
	<fa686aa40804210719x475698f8n3b82e795547bfc70@mail.gmail.com>
	<20080421143313.GB18008@polina.dev.rtsoft.ru>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d5966842fd6661f113bf850be8c3bfde@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 4/5] [POWERPC] QE: implement support for the GPIO LIB API
Date: Mon, 21 Apr 2008 18:30:42 +0200
To: avorontsov@ru.mvista.com
Cc: linuxppc-dev@ozlabs.org, David Brownell <david-b@pacbell.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Also, why is <bank> encoded in compatible?  Do the different banks
>> have different register interfaces?
>
> Yes, they could. For example, interrupt pins are bank-specific.

In what way?  If different banks just have different IRQ #s,
there are easier ways to express this.


Segher
