Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvwhx0XX6zDqB2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 20:11:12 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: kbuild test robot <lkp@intel.com>, linux-arch@vger.kernel.org,
 a.zummo@towertech.it, dalias@libc.org, linux-parisc@vger.kernel.org,
 linux-sh@vger.kernel.org, deller@gmx.de, linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, dhowells@redhat.com,
 linux-m68k@lists.linux-m68k.org, geert@linux-m68k.org, kbuild-all@01.org,
 rtc-linux@googlegroups.com,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH v2 4/6] rtc: parisc: provide rtc_class_ops directly
Date: Wed, 27 Apr 2016 12:10:28 +0200
Message-ID: <4761768.yGo2yiDr2v@wuerfel>
In-Reply-To: <201604270817.uNDAZuA5%fengguang.wu@intel.com>
References: <201604270817.uNDAZuA5%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 27 April 2016 08:22:24 kbuild test robot wrote:
> 
>    256  
>    257          memset(tm, 0, sizeof(*tm));
>    258          if (pdc_tod_read(&tod_data) < 0)
>    259                  return -EOPNOTSUPP;
>    260  
>    261          /* we treat tod_sec as unsigned, so this can work until year 2106 */
>  > 262          rtc_time64_to_tm(tod_data.tod_sec, &tm);
>    263          return rtc_valid_tm(tm);
>    264  }
> 

Fixed, thanks!

	Arnd
