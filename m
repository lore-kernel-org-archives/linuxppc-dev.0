Return-Path: <stern+48fbdcb8@rowland.harvard.edu>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
	by ozlabs.org (Postfix) with SMTP id AF73FDDEDA
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 02:28:44 +1100 (EST)
Date: Wed, 15 Oct 2008 11:28:33 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Kevin Diggs <kevdig@hypersurf.com>
Subject: Re: gigE 2.6.27 USB
In-Reply-To: <48F60493.8050708@hypersurf.com>
Message-ID: <Pine.LNX.4.44L0.0810151126100.2724-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 15 Oct 2008, Kevin Diggs wrote:

> I cut a deal with my 8600 to get it to boot 2.6.27. It does not seem
> to work right either.
> 
> The error message that shows up in dmesg is (the messages that show
> up for the gigE appear to be for two different busses (hubs?):
> 
> hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
> hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
> hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
> hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000

A bug was introduced in 2.6.27 and the fix is queued for 2.6.27.stable.  
The fix takes the form of two patches, which you can find here:

http://mirrors.med.harvard.edu/linux/kernel/people/gregkh/gregkh-2.6/gregkh-04-usb/ohci-allow-broken-controllers-to-auto-stop.patch
http://mirrors.med.harvard.edu/linux/kernel/people/gregkh/gregkh-2.6/gregkh-04-usb/usb-ohci-fix-endless-polling-behavior.patch

The second depends on the first, so you have to apply them both.

Alan Stern
