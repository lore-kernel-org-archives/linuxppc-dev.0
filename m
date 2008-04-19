Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 04E0BDE9DE
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Apr 2008 02:41:39 +1000 (EST)
Message-ID: <480A2117.7020502@scram.de>
Date: Sat, 19 Apr 2008 18:43:03 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] rtc-pcf8563: Add device ids table
References: <200804171708.32847.laurentp@cse-semaphore.com>	<20080418235451.2643183b@i1501.lan.towertech.it>	<20080419113417.19f5567a@hyperion.delvare>	<4809EF23.7070902@scram.de>
	<20080419162358.746b714c@hyperion.delvare>
In-Reply-To: <20080419162358.746b714c@hyperion.delvare>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Alessandro Zummo <alessandro.zummo@towertech.it>,
	i2c@lm-sensors.org, rtc-linux@googlegroups.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jean Delvare wrote:
> On Sat, 19 Apr 2008 15:09:55 +0200, Jochen Friedrich wrote:
>> Hi Jean,
>>
>>>>> Is the new-style driver conversion patch in 2.6.25-rc8-mm2 scheduled for
>>>>> 2.6.26 ?
>>>>  hope so! :)
>>> Note that this patch depends on i2c patches which aren't upstream yet.
>> Is there any chance they will got to 2.6.26?
> 
> I'm not sure. I didn't have the time to look at it myself, but I am
> under the impression that the powerpc folks are tired of having to wait
> for me and may push it to Linus through their tree? That would be fine
> with me, as I don't want to be the one delaying something many
> developers want (but I also can't sign patches I've not even read.)

The required patches are:

http://patchwork.ozlabs.org/linuxppc/patch?id=17833
http://patchwork.ozlabs.org/linuxppc/patch?id=17834

which are just the forward ported patches you sent to the poweprc mailing list some time ago:

http://patchwork.ozlabs.org/linuxppc/patch?id=16282
http://patchwork.ozlabs.org/linuxppc/patch?id=16283

Thanks,
Jochen
