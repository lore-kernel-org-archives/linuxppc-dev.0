Return-Path: <stern+4f088378@rowland.harvard.edu>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
 by ozlabs.org (Postfix) with SMTP id 10EEDB6F69
 for <linuxppc-dev@ozlabs.org>; Sat,  7 Jan 2012 05:09:49 +1100 (EST)
Date: Fri, 6 Jan 2012 13:03:07 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Matthias Fuchs <matthias.fuchs@esd.eu>
Subject: Re: Problem with full speed devices on PowerPC MPC5121 host port
In-Reply-To: <4F06E132.5070905@esd.eu>
Message-ID: <Pine.LNX.4.44L0.1201061258040.1326-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Greg KH <greg@kroah.com>, linux-usb@vger.kernel.org,
 linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 6 Jan 2012, Matthias Fuchs wrote:

> For my eyes it does not really look like a general USB issue.
> It looks like a problem with the Freescale EHCI implementation that is
> influenced by high interrupt or internal bus load caused by the flood ping.

Indeed, it might be a problem with the built-in Transaction Translator.  
That would explain why it affect full-speed devices.

However, I would expect the resetting the controller hardware (which 
happens when you reload the ehci-fsl driver) would fix any such issues.  
It's hard to imagine how a problem could survive a reset like that.

Alan Stern
