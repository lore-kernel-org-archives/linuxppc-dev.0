Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B472C1A0570
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 05:42:26 +1000 (AEST)
Date: Sun, 27 Sep 2015 12:42:24 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
 Joachim Eastwood <manabian@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 0/5] drivers/tty: make more bool drivers explicitly
 non-modular
Message-ID: <20150927194224.GA1055@kroah.com>
References: <1440020889-12120-1-git-send-email-paul.gortmaker@windriver.com>
 <20150926225347.GC1279@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150926225347.GC1279@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Sep 26, 2015 at 06:53:47PM -0400, Paul Gortmaker wrote:
> [[PATCH v2 0/5] drivers/tty: make more bool drivers explicitly non-modular] On 19/08/2015 (Wed 17:48) Paul Gortmaker wrote:
> 
> > [v2: drop dead module code removal from 8250_lpc18xx.c ; instead convert it
> >  from bool to tristate ; also add ack to hvc_console commit.]
> > 
> > This second set of patches to drivers/tty steps outside of the serial
> > dir, and an improved auditing finds two more serial drivers pretending
> > to be modular that really are not.
> 
> Hi Greg -- wondering if this is still in your to-do queue.  I see the
> patches to drivers/char that I sent about the same time made it onto
> your char-testing branch but not these onto tty-testing.

Yes, they are in my queue, haven't caught up with tty patches yet :(

> The reason I ask is that I've about a 1/2 dozen more similar patches
> that showed up once I started auditing non-x86 code.  I don't want to
> re-spam you with these along with the new ones, if these are still in
> your backlog for processing.

I can handle resends and other patches just fine, send away!

thanks,

greg k-h
