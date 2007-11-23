Return-Path: <jacmet@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by ozlabs.org (Postfix) with ESMTP id 38C19DDE40
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Nov 2007 21:34:54 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so567721uge
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Nov 2007 02:34:53 -0800 (PST)
To: Lorenz Kolb <linuxppcemb@lkmail.de>
Subject: Re: ML403 USB driver
References: <13858912.post@talk.nabble.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Fri, 23 Nov 2007 11:34:39 +0100
In-Reply-To: <13858912.post@talk.nabble.com> (Lorenz Kolb's message of "Tue\,
	20 Nov 2007 07\:21\:19 -0800 \(PST\)")
Message-ID: <87lk8pdzcw.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> "Lorenz" == Lorenz Kolb <linuxppcemb@lkmail.de> writes:

 Lorenz> Hi,

 Lorenz> we just tried the USB driver (from Peter Korsgaard) from
 Lorenz> Grant's virtex tree.

 Lorenz> Nevertheless we could not get the peripheral ports work as gadgets.
 Lorenz> Has anyone tried (and probably fixed) that before?

My driver so far only has host support. I'm working on the peripheral
support (or rather, a colleage of mine is) but it's quite early days
..

 Lorenz> Anyway, only one of the two peripheral ports seems to be active.

The Linux gadget stack only support a single peripheral port.

-- 
Bye, Peter Korsgaard
