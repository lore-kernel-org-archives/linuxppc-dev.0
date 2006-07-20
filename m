Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1D09B67BB7
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Jul 2006 23:13:17 +1000 (EST)
In-Reply-To: <44BF787F.3020203@cambridgebroadband.com>
References: <995B09A8299C2C44B59866F6391D2635058751@zch01exm21.fsl.freescale.net>
	<44BF787F.3020203@cambridgebroadband.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <26296171-D21D-4FF3-B9C5-C6378064AF44@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [Linux-ATM-General] mpc8360sar
Date: Thu, 20 Jul 2006 08:13:30 -0500
To: Alex Zeffertt <ajz@cambridgebroadband.com>
Cc: linux-atm-general@lists.sourceforge.net, linuxppc-embedded@ozlabs.org,
	Li Tony-r64360 <Tony.Li@freescale.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jul 20, 2006, at 7:35 AM, Alex Zeffertt wrote:

> Hi,
>
> Yes, UBR and AAL0 work.  I've also added support for the qos  
> parameters
> min_pcr, pcr, and max_pcr.
>
> I used ltib-mpc832xemds-20060615 as my base.  More details are on the
> website.
>
> BTW, I left all your code in.  There's a simple config option now  
> which
> allows you to choose between the two drivers.
>
> Alex
>
> PS Thanks!

Any reason we dont try to get your work up stream into the mainline  
kernel?

- kumar

> Li Tony-r64360 wrote:
>> Hi, alex
>> I am tony li.  I am glad to know that you add many features support.
>> Do you have test the UBR and AAL0 ? I am lack of enviroment test them
>> now.
>> I have not read your code detailly.:)
>> And which ltib release version is your base ? I have updated my  
>> code a
>> little which contain a workaround for a bug.
>>
>> Tony.li
>>
>> -----Original Message-----
>> From: linux-atm-general-bounces@lists.sourceforge.net
>> [mailto:linux-atm-general-bounces@lists.sourceforge.net] On Behalf Of
>> Alex Zeffertt
>> Sent: Thursday, July 20, 2006 6:40 PM
>> To: linuxppc-embedded@ozlabs.org;
>> linux-atm-general@lists.sourceforge.net
>> Subject: [Linux-ATM-General] mpc8360sar
>>
>> Hi lists,
>>
>> I'm writing to announce a new project http:// 
>> mpc8360sar.sourceforge.net
>> .
>> This is an ATM driver for the QUICC Engine (QE) of the PowerQUICC  
>> II Pro
>> range of processors.  It is based on Tony Li's fsl-atm driver and my
>> mpc8260sar driver.  I've basically used Tony's driver for the most  
>> low
>> level stuff and ported a lot of extra functionality from my PQII  
>> driver.
>>
>> You will need the Linux BSP from Freescale to build this driver.
>>
>> I have only tested this driver on mpc832xe-mds, but it should also  
>> work
>> on the mpc8360e-pb board.
>>
>> If you use mpc8360sar, please let me know how you get on.  In  
>> particular
>> let me know if you work out how to stop the QE occaisionally  
>> corrupting
>> the TCT when using external channels.
>>
>> Regards,
>>
>> Alex
>>
>> --------------------------------------------------------------------- 
>> ---
>> -
>> Take Surveys. Earn Cash. Influence the Future of IT Join
>> SourceForge.net's Techsay panel and you'll get the chance to share  
>> your
>> opinions on IT & business topics through brief surveys -- and earn  
>> cash
>> http://www.techsay.com/default.php? 
>> page=join.php&p=sourceforge&CID=DEVDE
>> V
>> _______________________________________________
>> Linux-atm-general mailing list
>> Linux-atm-general@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-atm-general
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
