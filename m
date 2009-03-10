Return-Path: <alessandro.zummo@towertech.it>
Received: from mx0.towertech.it (mx0.towertech.it [213.215.222.73])
	by ozlabs.org (Postfix) with SMTP id C74D5DE0DC
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 20:39:51 +1100 (EST)
Date: Tue, 10 Mar 2009 10:39:48 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: rtc-linux@googlegroups.com
Subject: Re: [rtc-linux] Re: [PATCH 7/7] powerpc/ps3: Add rtc-ps3
Message-ID: <20090310103948.6e180eea@i1501.lan.towertech.it>
In-Reply-To: <alpine.LRH.2.00.0903101015470.24318@vixen.sonytel.be>
References: <1236605183-22718-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-4-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-5-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-6-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-7-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-8-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<49B5618E.9050501@am.sony.com>
	<alpine.LRH.2.00.0903101015470.24318@vixen.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-m68k@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kyle McMartin <kyle@mcmartin.ca>,
	linuxppc-dev@ozlabs.org, Paul Mundt <lethal@linux-sh.org>,
	Geert.Uytterhoeven@sonycom.com, Dann Frazier <dannf@dannf.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 10 Mar 2009 10:21:14 +0100 (CET)
Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:

> Alessandro prefers not to have generic RTC drivers on top of some other
> abstraction, but wants platform/chip-specific drivers under drivers/rtc/
> instead. The goal is to convert all RTC drivers buried in platform code
> to separate RTC drivers.
> 
> (Alessandro, please correct me if I'm wrong)

 yes, that's my dream :)

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
