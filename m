Return-Path: <t.denzinger@lesametric.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id B06D367A39
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Dec 2006 02:30:50 +1100 (EST)
Message-Id: <14180968.30361165332648093.JavaMail.servlet@kundenserver>
From: Thomas Denzinger <t.denzinger@lesametric.de>
To: <mgalassi@c-cor.com>
Subject: AW: Re: Updating plb_temac to version 3.00.a on XILINX ml403 board
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 05 Dec 2006 16:30:48 +0100
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thank you Michael and also Ming for your help!

I modified my design according Michael's files and compiled everything. But with my 2.4.20 MontaVista-Kernel and the XILINX BSP-software 'No PHY detected. Assuming a PHY at address 0.' errormessage is printed out and because of that a wrong speed (10Mbits) is set. 
I have to find out now why the PHY is not detected. I assume that only the GMII interface is used for that. Am I right?

Thomas

>>I have a plb_temac-design based on XAPP902 demodesign running. It's 
>>based on plb_temac version 2.00.a and hard_temac version 1.00.a.
>>I tried to update to version 3.00 manually, because of incompatibility 
>>for automatic update.
>>Up to now without success.
>>Can somebody help me with a  copy of .mhs and .ucf files, where the 
>>interface to the PHY and the PPC is correct?
>
>They're largish so I put copies of the ones I used with the ml403 on my
>web server, look for:
>
>http://www.xyz.com/system.ucf
>http://www.xyz.com/system.mhs
>
>I didn't clean out other unrelated changes.
>
>-michael



-- 
Thomas Denzinger
LesaMetric GmbH 
Hauptstrasse 46
35649 Bischoffen

Tel.: 06444/931928
Fax : 06444/931912
