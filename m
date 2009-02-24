Return-Path: <alessandro.zummo@towertech.it>
Received: from mx0.towertech.it (mx0.towertech.it [213.215.222.73])
	by ozlabs.org (Postfix) with SMTP id 767ABDDDA1
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2009 05:37:14 +1100 (EST)
Date: Tue, 24 Feb 2009 19:37:08 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: rtc-linux@googlegroups.com
Subject: Re: [rtc-linux] Re: [PATCH/RFC 0/5] Generic RTC class driver
Message-ID: <20090224193708.5f8be86c@i1501.lan.towertech.it>
In-Reply-To: <alpine.LRH.2.00.0902241848500.544@vixen.sonytel.be>
References: <1235144809-32468-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<20090220170454.04382e9e@i1501.lan.towertech.it>
	<alpine.LRH.2.00.0902231319170.22762@vixen.sonytel.be>
	<20090223160506.04e347c7@i1501.lan.towertech.it>
	<alpine.LRH.2.00.0902241848500.544@vixen.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Richard Zidlicky <rz@linux-m68k.org>, linux-parisc@vger.kernel.org,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	David@ozlabs.org, Kyle McMartin <kyle@mcmartin.ca>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	Geert.Uytterhoeven@sonycom.com, Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 24 Feb 2009 18:56:03 +0100 (CET)
Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:

> 
> On Mon, 23
> > 
> >  I'd start writing a working driver and then see how we should eventually
> >  adapt the rtc subsystem to cope with your needs.
> 
> OK, so here's a first example: rtc-ps3.
> 
> Note that this single patch adds 100+ lines of code, while my previous patch
> series removed 500+ lines of code, while solving the autoloading problem for
> several ppc and m68k platforms.

 This patch has a much cleaner approach, imho.

> Converting all (ca. 20?) ppc and m68k RTC support code into individual RTC
> class drivers would add ca. 100+ lines of code for each individual driver.



 How different are all of those boards? It's simply a matter
 of parameters and offsets? can we group them somehow?

 
-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
