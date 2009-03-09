Return-Path: <alessandro.zummo@towertech.it>
Received: from mx0.towertech.it (mx0.towertech.it [213.215.222.73])
	by ozlabs.org (Postfix) with SMTP id DF016DE0CB
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 05:43:11 +1100 (EST)
Date: Mon, 9 Mar 2009 19:43:07 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: rtc-linux@googlegroups.com
Subject: Re: [rtc-linux] Re: [PATCH 7/7] powerpc/ps3: Add rtc-ps3
Message-ID: <20090309194307.154f3e95@i1501.lan.towertech.it>
In-Reply-To: <49B55A21.2010801@am.sony.com>
References: <1236605183-22718-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-4-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-5-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-6-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-7-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-8-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<20090309151216.17f13862@i1501.lan.towertech.it>
	<49B55A21.2010801@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-m68k@vger.kernel.org, linux-parisc@vger.kernel.org, Dann, Kyle,
	linux-kernel@vger.kernel.org, McMartin <kyle@mcmartin.ca>,
	linuxppc-dev@ozlabs.org, Paul Mundt <lethal@linux-sh.org>,
	Geert.Uytterhoeven@sonycom.com, Frazier <dannf@dannf.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 9 Mar 2009 11:04:17 -0700
Geoff Levand <geoffrey.levand@am.sony.com> wrote:

> 
> Hi,
> 
> On 03/09/2009 07:12 AM, Alessandro Zummo wrote:
> > On Mon,  9 Mar 2009 14:26:23 +0100
> > Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
> >> +
> >> +MODULE_AUTHOR("Sony Corporation");
> > 
> >  real name, if possible and a contact address
> >  here . Just in case I need someone to bother :)
> 
> Please look at the MAINTAINERS file, that will give
> the contact for PS3.  It is much easier to maintain
> a single place for the contact than many spread
> throughout the kernel sources.

 Having it in MODULE_AUTHOR allow my scripts to automatically
 send an email when appropriate.

 MAINTAINERS lists the files with an arbitrary
 driver title so that the search must be made by an human and there's
 no field that links a person to a specific .c .

 so every time I want to address someone I need to check MODULE_AUTHOR,
 the git log and the MAINTAINERS file.

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
