Return-Path: <logout128@yahoo.com>
Received: from nm8-vm3.bullet.mail.gq1.yahoo.com
 (nm8-vm3.bullet.mail.gq1.yahoo.com [98.136.218.226])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 425511A0947
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Nov 2014 20:12:00 +1100 (AEDT)
Message-ID: <546DB05A.7040704@yahoo.com>
Date: Thu, 20 Nov 2014 10:11:54 +0100
From: =?UTF-8?B?TWFydGluIEt1a2HEjQ==?= <logout128@yahoo.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Fan management PowerMac7,2
References: <546C8763.6020209@yahoo.com> <546D53F5.4030205@daenzer.net>
In-Reply-To: <546D53F5.4030205@daenzer.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/20/2014 03:37 AM, Michel Dänzer wrote:
> On 19.11.2014 21:04, Martin Kukač wrote:
>> Hello,
>>
>> I was directed to this list on #ppc64/freenode IRC channel. I have
>> PowerMac7,2 (AGP, 2xPowerPC 970(2.2) 2GHz) and I wanted to try kernel
>> supporting kvm-pr module, which is not in 3.2.63 kernel provided with
>> Debian Wheezy. I downloaded 3.14.24, compiled it using original config
>> from 3.2.63 and after booting fan management does not work. I tried
>> therm_pm72 (which is deprecated, but works well with Debian kernel) and
>> windfarm_pm72 modules, but neither worked - after about five minutes
>> from boot all fans go to maximum and stay this way no matter the CPU
>> load or frequency.
>>
>> I downloaded vanilla 3.2.64, compiled it the same way and there fans
>> work with therm_p72 well. This kernel does not have kvm-pr, so I
>> reverted to original kernel provided with Wheezy.
>>
>> I looked to logs, i tried to search the web whether anyone had already
>> the same problem, but it seems that nobody else described not to say
>> solved this. Can anyone please point me to anything that would help? I
>> can provide whatever log files required.
>
> Might be the same problem as discussed in
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2013-August/109700.html
> and the following posts: The i2c_powermac module doesn't get loaded
> automatically with recent kernels.
>
>

Thanks! That helped for therm_pm72 module, it works now as expected.

(It didn't help for windfarm_pm72 though, if I put it in /etc/modules 
with i2c_powermac and remove therm_pm72, fans still go to full speed in 
a few minutes. It's not problem for now, but if I understand it 
correctly, therm_pm72 is deprecated and will be removed one day, so it 
could be problem after that.)

Martin
