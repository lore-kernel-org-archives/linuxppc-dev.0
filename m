Return-Path: <x.xiao@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 3C45FDDEE0
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Dec 2006 08:07:11 +1100 (EST)
Message-ID: <459431F9.4090204@freescale.com>
Date: Thu, 28 Dec 2006 15:07:05 -0600
From: Xianghua Xiao <x.xiao@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: kurobox kernel
References: <fa.ne7N9dqjDz5qS4D/fowPKdPc4ZY@ifi.uio.no>	<fa.pM17YEcICUlveSt/vbSKGv6sFWk@ifi.uio.no>	<45902A6F.4000100@glines.org>	<Pine.LNX.4.60.0612252128530.3424@poirot.grange>	<459046FE.9030008@glines.org>	<Pine.LNX.4.60.0612252349040.3424@poirot.grange>	<45905997.5080403@glines.org>	<Pine.LNX.4.60.0612260019430.3424@poirot.grange>	<45918294.3080303@glines.org>	<Pine.LNX.4.60.0612262159180.3245@poirot.grange>	<45942EBF.5060201@glines.org>
	<459430E5.1040203@freescale.com>
In-Reply-To: <459430E5.1040203@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Mark Glines <mark@glines.org>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Reply-To: x.xiao@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

you can find the newest dtc tool at http://jdl.com/git_repos/

Scott Wood wrote:
> Mark Glines wrote:
>   
>> $ dtc -f -I dts -O dtb -o kuroboxHG.dtb -V 16 kuroboxHG.dts
>> DTC: dts->dtb  on file "kuroboxHG.dts"
>> ERROR: Missing /chosen node
>> Input tree has errors
>>
>>     
the warning is fine. the "chosen" node is filled out by u-boot(instead 
of the generated dtb file) for the time being. you can do a quick 
reverse dtc to check your dtb binary:

$dtc -f -I dtb -O dts -V 0x10 kuroboxHG.dtb > kuroboxHG.dts.check
>> So, uh... is the *.dts file in 2.6.20-rc2 bad, or am I compiling it 
>> wrongly?  (And is this normally done by hand, or as part of the kernel 
>> build process?)
>>     
>
> You need to pass the -f option to dtc.  Hopefully, dtc will be fixed to 
> not complain about this at some point.
>
> -Scott
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>   
