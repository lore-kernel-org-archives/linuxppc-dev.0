Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
 by lists.ozlabs.org (Postfix) with ESMTP id 8EB0F1A08C8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Nov 2014 13:47:27 +1100 (AEDT)
Message-ID: <546D53F5.4030205@daenzer.net>
Date: Thu, 20 Nov 2014 11:37:41 +0900
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
MIME-Version: 1.0
To: =?UTF-8?Q?Martin_Kuka=c4=8d?= <logout128@yahoo.com>
Subject: Re: Fan management PowerMac7,2
References: <546C8763.6020209@yahoo.com>
In-Reply-To: <546C8763.6020209@yahoo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 19.11.2014 21:04, Martin Kukač wrote:
> Hello,
>
> I was directed to this list on #ppc64/freenode IRC channel. I have
> PowerMac7,2 (AGP, 2xPowerPC 970(2.2) 2GHz) and I wanted to try kernel
> supporting kvm-pr module, which is not in 3.2.63 kernel provided with
> Debian Wheezy. I downloaded 3.14.24, compiled it using original config
> from 3.2.63 and after booting fan management does not work. I tried
> therm_pm72 (which is deprecated, but works well with Debian kernel) and
> windfarm_pm72 modules, but neither worked - after about five minutes
> from boot all fans go to maximum and stay this way no matter the CPU
> load or frequency.
>
> I downloaded vanilla 3.2.64, compiled it the same way and there fans
> work with therm_p72 well. This kernel does not have kvm-pr, so I
> reverted to original kernel provided with Wheezy.
>
> I looked to logs, i tried to search the web whether anyone had already
> the same problem, but it seems that nobody else described not to say
> solved this. Can anyone please point me to anything that would help? I
> can provide whatever log files required.

Might be the same problem as discussed in 
https://lists.ozlabs.org/pipermail/linuxppc-dev/2013-August/109700.html 
and the following posts: The i2c_powermac module doesn't get loaded 
automatically with recent kernels.


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer
