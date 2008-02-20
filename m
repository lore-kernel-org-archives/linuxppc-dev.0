Return-Path: <jacmet@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.159])
	by ozlabs.org (Postfix) with ESMTP id 01111DE1CB
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2008 03:59:51 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id 16so1744343fgg.39
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 08:59:48 -0800 (PST)
To: Greg KH <greg@kroah.com>
Subject: Re: [patch v8 1/4] USB: add Cypress c67x00 low level interface code
References: <20080220090727.904160000@sunsite.dk>
	<20080220091400.882581000@sunsite.dk>
	<20080220161343.GC2658@kroah.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Wed, 20 Feb 2008 17:59:36 +0100
In-Reply-To: <20080220161343.GC2658@kroah.com> (Greg KH's message of "Wed\,
	20 Feb 2008 08\:13\:43 -0800")
Message-ID: <87r6f7d0nb.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: linuxppc-dev@ozlabs.org, dbrownell@users.sourceforge.net,
	stern@rowland.harvard.edu, linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Greg" == Greg KH <greg@kroah.com> writes:

Hi,

 >> drivers/usb/c67x00/c67x00.h        |  285 ++++++++++++++++++++++++++

 Greg> Why not drivers/usb/hcd/c67x00/ instead?

Because the device can do both host and peripheral (E.G. see patch 4
in the series).

We could put it under hcd for now and then move it once the gadget
driver gets finished/merged, but that seems silly to me..

-- 
Bye, Peter Korsgaard
