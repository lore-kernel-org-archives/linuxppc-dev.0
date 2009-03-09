Return-Path: <alessandro.zummo@towertech.it>
Received: from mx0.towertech.it (mx0.towertech.it [213.215.222.73])
	by ozlabs.org (Postfix) with SMTP id 5B175DDF96
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 01:12:22 +1100 (EST)
Date: Mon, 9 Mar 2009 15:12:16 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: rtc-linux@googlegroups.com
Subject: Re: [rtc-linux] [PATCH 7/7] powerpc/ps3: Add rtc-ps3
Message-ID: <20090309151216.17f13862@i1501.lan.towertech.it>
In-Reply-To: <1236605183-22718-8-git-send-email-Geert.Uytterhoeven@sonycom.com>
References: <1236605183-22718-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-4-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-5-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-6-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-7-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-8-git-send-email-Geert.Uytterhoeven@sonycom.com>
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

On Mon,  9 Mar 2009 14:26:23 +0100
Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:

 Hi,

   just a few notes:

> +
> +static int ps3_get_time(struct device *dev, struct rtc_time *tm)
> +{
> +	to_tm(read_rtc() + ps3_os_area_get_rtc_diff(), tm);
> +	tm->tm_year -= 1900;
> +	tm->tm_mon -= 1;
> +	return 0;
> +}

 this should be return rtc_valid_tm() .

 can't you use functions from rtc-lib.c instead of 
 that to_tm ?

> +
> +MODULE_AUTHOR("Sony Corporation");

 real name, if possible and a contact address
 here . Just in case I need someone to bother :)

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
