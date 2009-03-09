Return-Path: <lethal@linux-sh.org>
Received: from master.linux-sh.org (124x34x33x190.ap124.ftth.ucom.ne.jp
	[124.34.33.190])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 17235DDEF3
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 02:50:17 +1100 (EST)
Date: Tue, 10 Mar 2009 00:46:17 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH 0/7] Generic RTC class driver
Message-ID: <20090309154617.GA31103@linux-sh.org>
References: <1236605183-22718-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1236605183-22718-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
Cc: linux-m68k@vger.kernel.org,
	Alessandro Zummo <alessandro.zummo@towertech.it>,
	rtc-linux@googlegroups.com, linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kyle McMartin <kyle@mcmartin.ca>,
	linuxppc-dev@ozlabs.org, Dann Frazier <dannf@dannf.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 09, 2009 at 02:26:16PM +0100, Geert Uytterhoeven wrote:
> Paul: Feel free to add your SuperH support.
> 
> I suppose the easiest way for this to go in is through Kyle's PA-RISC tree, as
> he already has the preceding patches? Can I have your acks, please?
> 
I'll add the SH support once the patch set is merged, it's not a very
pressing matter, so no need to make the patch juggling any more
complicated :-)
