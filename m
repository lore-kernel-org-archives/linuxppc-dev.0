Return-Path: <alessandro.zummo@towertech.it>
Received: from mx0.towertech.it (mx0.towertech.it [213.215.222.73])
	by ozlabs.org (Postfix) with SMTP id 60340DDFA4
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 22:29:35 +1000 (EST)
Date: Tue, 19 Jun 2007 14:29:23 +0200
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Mark Zhan <rongkai.zhan@windriver.com>
Subject: Re: [PATCH] Add the support of ST M48T59 RTC chip in rtc-class
	driver subsystem
Message-ID: <20070619142923.4244b0ec@inspiron>
In-Reply-To: <1181657546.3975.25.camel@mark>
References: <1181548600.5217.16.camel@mark> <20070611121145.GA11297@iram.es>
	<1181656776.3975.16.camel@mark> <1181657546.3975.25.camel@mark>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	rtc-linux@googlegroups.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 12 Jun 2007 22:12:25 +0800
Mark Zhan <rongkai.zhan@windriver.com> wrote:

> Hi All,
> 
> For the platform data of RTC chip driver, you know, currently we use
> different header files to define different driver-specific platform data
> structure. For example: linux/m48t86.h, linux/rtc-v3020.h....
> 
> Could we consider to add a new header file linux/rtc_pd.h to gather them
> together, and remove those rtc platform data header files in
> include/linux directory?

 files in linux/ are the ones that are required by other modules
 of the kernel and it wouldn't be fair to combine all of them.

 I'd rather add a linux/rtc directory.


-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
