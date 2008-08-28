Return-Path: <stern+48acf28e@rowland.harvard.edu>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
	by ozlabs.org (Postfix) with SMTP id 51D42DE4B1
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2008 06:16:17 +1000 (EST)
Date: Thu, 28 Aug 2008 16:16:15 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] usb: add Freescale QE/CPM USB peripheral controller driver
In-Reply-To: <48B6E62D.4060606@freescale.com>
Message-ID: <Pine.LNX.4.44L0.0808281613540.3844-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: dbrownell@users.sourceforge.net, Arnd Bergmann <arnd@arndb.de>,
	greg@kroah.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 28 Aug 2008, Scott Wood wrote:

> Alan Stern wrote:
> > This was done deliberately.  The relevant standards state that a USB
> > device can have no more than one peripheral interface.
> 
> Does building a kernel image that can run on different hardware without 
> rebuilding also violate the "relevant standards"?

No.  That isn't what Arnd was concerned about.  He noted that even if 
you did build multiple modules, only one of them could be loaded at any 
time.

> And who's to say that there aren't multiple USB devices on a single 
> board, that just happen to share a CPU and memory? :-)

That's why I don't fully support this decision.  But I wanted to point 
out that there _was_ a conscious decision, as opposed to bad 
programming through sheer carelessness.

Alan Stern
