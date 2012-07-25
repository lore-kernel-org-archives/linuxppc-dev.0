Return-Path: <ronne@list.ru>
Received: from smtp3.mail.ru (smtp3.mail.ru [94.100.176.131])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4D98A2C0081
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2012 17:29:50 +1000 (EST)
Message-ID: <500FA063.4070203@list.ru>
Date: Wed, 25 Jul 2012 11:29:39 +0400
From: Andrey Gusev <ronne@list.ru>
MIME-Version: 1.0
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "paulus@samba.org" <paulus@samba.org>
Subject: Re: Errors related to i2c-powermac on the G4
References: <50096F45.80601@list.ru>
In-Reply-To: <50096F45.80601@list.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

20.07.2012 18:46, Andrey Gusev пишет:
> Hi!
> I build kernel from git and can see errors in dmesg on boot. 3.4.5 
> doesn't have such issue.
> git show | head -n2
> commit 85efc72a0218335324d358ac479a04c16316fd4d
>
Actual for 3.5.0
[ 2.841441] i2c /dev entries driver
[ 2.850155] i2c i2c-0: therm_windtunnel: attach_adapter method is deprecated
[ 2.858330] i2c i2c-0: Please use another way to instantiate your i2c_client
[ 2.866457] PowerMac i2c bus pmu 2 registered
[ 2.874885] i2c i2c-1: therm_windtunnel: attach_adapter method is deprecated
[ 2.882965] i2c i2c-1: Please use another way to instantiate your i2c_client
[ 2.890928] PowerMac i2c bus pmu 1 registered
[ 2.899526] i2c i2c-2: therm_windtunnel: attach_adapter method is deprecated
[ 2.907463] i2c i2c-2: Please use another way to instantiate your i2c_client
[ 2.915397] PowerMac i2c bus mac-io 0 registered
[ 2.923272] i2c i2c-2: i2c-powermac: invalid reg on 
/pci@f2000000/mac-io@17/i2c@18000/cereal
[ 2.931286] i2c i2c-2: i2c-powermac: invalid reg on 
/pci@f2000000/mac-io@17/i2c@18000/deq
[ 2.939246] i2c i2c-2: i2c-powermac: invalid reg on 
/pci@f2000000/mac-io@17/i2c@18000/i2c-modem
[ 2.947580] i2c i2c-3: therm_windtunnel: attach_adapter method is deprecated
[ 2.955559] i2c i2c-3: Please use another way to instantiate your i2c_client
[ 2.964492] PowerMac i2c bus uni-n 1 registered
[ 2.972493] i2c i2c-3: i2c-powermac: invalid reg on 
/uni-n@f8000000/i2c@f8001000/cereal
[ 2.980977] usb 1-1: new full-speed USB device number 2 using ohci_hcd
[ 2.989404] i2c i2c-4: therm_windtunnel: attach_adapter method is deprecated
[ 2.997793] i2c i2c-4: Please use another way to instantiate your i2c_client
[ 3.007320] DS1775 digital thermometer [@49]
[ 3.015574] Temp: 33.0 C Hyst: 75.0 C OS: 80.0 C
[ 3.024410] ADM1030 fan controller [@2c]
[ 3.032533] PowerMac i2c bus uni-n 0 registered
[ 3.040575] i2c i2c-4: Failed to register i2c client MAC,adm1030 at 0x2c 
(-16)
[ 3.048714] i2c i2c-4: i2c-powermac: Failure to register 
/uni-n@f8000000/i2c@f8001000/fan@58
[ 3.057147] i2c i2c-4: Failed to register i2c client MAC,ds1775 at 0x49 
(-16)
[ 3.065304] i2c i2c-4: i2c-powermac: Failure to register 
/uni-n@f8000000/i2c@f8001000/temp-monitor@92
[ 3.073475] i2c i2c-4: i2c-powermac: invalid reg on 
/uni-n@f8000000/i2c@f8001000/cereal
[ 3.082701] device-mapper: ioctl: 4.22.0-ioctl (2011-10-19) initialised: 
dm-devel@redhat.com

Andrey
