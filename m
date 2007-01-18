Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc3-s4.bay0.hotmail.com (bay0-omc3-s4.bay0.hotmail.com
	[65.54.246.204]) by ozlabs.org (Postfix) with ESMTP id AE589DDEC2
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Jan 2007 01:05:29 +1100 (EST)
Message-ID: <BAY110-F3842A05869014111B3DC36B2AA0@phx.gbl>
In-Reply-To: <627126.73541.qm@web30001.mail.mud.yahoo.com>
From: "Ming Liu" <eemingliu@hotmail.com>
To: indianirav@yahoo.com, linuxppc-embedded@ozlabs.org
Subject: RE: how to cross compile 2.4.18
Date: Thu, 18 Jan 2007 14:05:26 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,
Check the cmds provided by the installed cross-compiler. The cross-compiler 
cmd may looks like powerpc-...-gcc. Use this one instead of the normal gcc. 
Then the binary file is for your target platform.

BR
Ming


>From: patel nirav <indianirav@yahoo.com>
>To: linux ppc <linuxppc-embedded@ozlabs.org>
>Subject: how to cross compile 2.4.18
>Date: Thu, 18 Jan 2007 05:29:34 -0800 (PST)
>
>Hello friends
>   I have installed crosstool-0.42 for the powerpc 604 in the
>   /opt/crosstool.
>   Now At the time of Installation I use gcc-3.4.1, glibc-2.3.3 and linux 
kernel 2.4.18,
>   Now my question is how to use the crosstool to cross compile the linux 
kernel 2.4.18 for power pc.
>
>   Thanks.
>
>
>Nirav J Patel
>M.Tech(CSE),
>Nirma University,
>Ahmedabad-382481.
>9925138959
>
>---------------------------------
>Sucker-punch spam with award-winning protection.
>  Try the free Yahoo! Mail Beta.


>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded

_________________________________________________________________
享用世界上最大的电子邮件系统— MSN Hotmail。  http://www.hotmail.com  
