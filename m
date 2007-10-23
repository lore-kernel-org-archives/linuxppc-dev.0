Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7778CDDE9B
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 03:04:05 +1000 (EST)
In-Reply-To: <20071008142658.GA15197@ru.mvista.com>
References: <20071008142658.GA15197@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e1b19c12c7006e763a56627fa9a05ec9@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] PowerPC 440EPx Sequoia USB OHCI DTS entry
Date: Tue, 23 Oct 2007 19:03:55 +0200
To: Valentine Barshak <vbarshak@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +			compatible = "ohci-be";

Can we fix this please, in the same way as with EHCI?  I.e., the
"compatible" should say it is USB, e.g. "usb-ohci"; and the
"big-endian" quirkiness should be expressed by a property, not by
the "compatible" name (since that would lead to exponential
explosion of all possible combinations of quirks, if nothing else).


Segher
