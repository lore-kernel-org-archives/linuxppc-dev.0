Return-Path: <jacmet@gmail.com>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.191])
	by ozlabs.org (Postfix) with ESMTP id 3B6BEDDF8D
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2008 03:57:29 +1100 (EST)
Received: by mu-out-0910.google.com with SMTP id w8so2137527mue.1
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 08:57:23 -0800 (PST)
To: Greg KH <greg@kroah.com>
Subject: Re: [patch v7 3/4] USB: add Cypress c67x00 OTG controller HCD driver
References: <20080219150916.263032000@sunsite.dk>
	<20080219151149.684610000@sunsite.dk>
	<20080219235554.GA13304@kroah.com>
	<87bq6cf1cb.fsf@macbook.be.48ers.dk> <20080220161608.GE2658@kroah.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Wed, 20 Feb 2008 17:57:06 +0100
In-Reply-To: <20080220161608.GE2658@kroah.com> (Greg KH's message of "Wed\,
	20 Feb 2008 08\:16\:08 -0800")
Message-ID: <874pc3efbx.fsf@macbook.be.48ers.dk>
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
 Greg> I don't know, I selected the config option, and yet, it built
 Greg> as if it wasn't set.

Sorry, I cannot reproduce that here. Could you try again?

 Greg> Can you move the files under the hcd/ subdir

Sorry, I don't think that's a good idea as the hardware can do
peripheral as well, and as you can see in patch 4, a gadget driver is
on it's way.

 Greg> run it through checkpatch.pl and fix up the __FUNCTION__
 Greg> warnings, and then I'll be willing to test it again :)

Ahh, that seems to be a pretty new warning in checkpatch - I atleast
haven't seen it before. The other things it complains about seems to
be rubbish though (except for the single indented label).

I'll send a v9 series shortly.

-- 
Bye, Peter Korsgaard
