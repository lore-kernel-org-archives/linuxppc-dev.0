Return-Path: <jacmet@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by ozlabs.org (Postfix) with ESMTP id C545BDDE00
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 07:16:50 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so951239uge.0
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jan 2008 12:16:48 -0800 (PST)
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [patch v4 0/4] Cypress c67x00 (EZ-Host/EZ-OTG) support
References: <20080121103434.397382000@sunsite.dk>
	<fa686aa40801210911q4ce90816tebafa46e68a3f980@mail.gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Mon, 21 Jan 2008 21:16:43 +0100
In-Reply-To: <fa686aa40801210911q4ce90816tebafa46e68a3f980@mail.gmail.com>
	(Grant Likely's message of "Mon\, 21 Jan 2008 10\:11\:18 -0700")
Message-ID: <87zluz0w9g.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: linuxppc-dev@ozlabs.org, dbrownell@users.sourceforge.net,
	linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Grant" == Grant Likely <grant.likely@secretlab.ca> writes:

Hi,

 >> Changes since v3:
 >> - Lots of cleanups: checkpatch, interrupt handling, c67x00_ prefixes, ..
 >> - The dummy platform_device's created per serial engine are gone.
 >> - Gadget driver (WIP)

 Grant> Can you please post/publish the diff between v3 and this series?

Sure, http://peter.korsgaard.com/c67x00-v3-v4.patch (not posting as
it's more than 100k)

-- 
Bye, Peter Korsgaard
