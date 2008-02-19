Return-Path: <alessandro.zummo@towertech.it>
Received: from mx0.towertech.it (mx0.towertech.it [213.215.222.73])
	by ozlabs.org (Postfix) with SMTP id 8D996DE213
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 03:34:25 +1100 (EST)
Date: Tue, 19 Feb 2008 17:24:50 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] Convert pfc8563 i2c driver from old style to new style
Message-ID: <20080219172450.0e4ccc7c@i1501.lan.towertech.it>
In-Reply-To: <20080219161020.61f7ec10@hyperion.delvare>
References: <20080121200901.15517.30253.stgit@terra.home>
	<20080219161020.61f7ec10@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 19 Feb 2008 16:10:20 +0100
Jean Delvare <khali@linux-fr.org> wrote:

> Hi Jon,
> 
> On Mon, 21 Jan 2008 15:09:01 -0500, Jon Smirl wrote:
> > Convert pfc8563 i2c driver from old style to new style.
> > 
> > Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
> > ---
> > 
> >  drivers/rtc/rtc-pcf8563.c |  107 +++++++++++----------------------------------
> >  1 files changed, 27 insertions(+), 80 deletions(-)
> 
> Preliminary note: this driver belongs to the RTC subsystem, so it will
> be up to Alessandro Zummo (Cc'd) to push this patch upstream... when it
> is ready to go there.

 A conversion to new style for this driver has already been
 pushed upstream. Adapting platforms to instantiate the device
 should be fairly easy, especially when you use the dts.

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
