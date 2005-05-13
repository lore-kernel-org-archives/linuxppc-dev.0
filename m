Return-Path: <wd@denx.de>
Received: from mailout09.sul.t-online.com (mailout09.sul.t-online.com
	[194.25.134.84]) by ozlabs.org (Postfix) with ESMTP id 78B4B679E1
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 14 May 2005 09:42:44 +1000 (EST)
To: "Martin, Tim" <tim.martin@viasat.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 13 May 2005 15:11:29 PDT."
	<846BA3AF7C8A2048937F1801FD3129C902DB5942@messenger.viasat.com>
Date: Sat, 14 May 2005 01:42:28 +0200
Sender: wd@denx.de
Message-Id: <20050513234233.4C186C1512@atlas.denx.de>
Cc: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Subject: Re: MPC860 CP / CPM Misbehaving 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <846BA3AF7C8A2048937F1801FD3129C902DB5942@messenger.viasat.com> you wrote:
> 
> I'm using a custom MPC860 based embedded board and having problems with SCC1
> and SMC1 reception.  I have SCC1 setup in ethernet mode, and SMC1 setup in
> UART mode.  The general problem manifests itself as getting receive buffer
> descriptors (BDs) from the CPM with the OV bit set (bit 14 of the RxBD
> status/control field, "Overrun. Set when a receiver overrun occurs during
> reception").
...
> This isn't a board hardware problem, the board runs fine with other software
> (different operating system, etc).  It's most likely a configuration problem
> on my end.

<speculation>

Are you 100% sure that your SDRAM is working fine when stressed  with
burst mode accesses?

See http://www.denx.de/twiki/bin/view/DULG/UBootCrashAfterRelocation
</speculation>

> My thoughts are that it's almost as if the CP (CPM RISC processor) or SDMA
> is being occasionally frozen out while the core PowerPC MPC860 processor is

You may see "funny" problems when your SDRAM is  not  working  right.
And  yes,  this may happen especially on DMA transfers which will use
burst mode.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
        ... Hiroshima 45 ... Chernobyl 86 ... Windows 95 ...
