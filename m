Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc1-s26.bay0.hotmail.com (bay0-omc1-s26.bay0.hotmail.com
	[65.54.246.98]) by ozlabs.org (Postfix) with ESMTP id 2FFAF67C6C
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  6 Oct 2006 18:24:05 +1000 (EST)
Message-ID: <BAY110-F105F9728CF6F7DBD6CF176B2130@phx.gbl>
In-Reply-To: <20061005154700.5018.qmail@web83212.mail.mud.yahoo.com>
From: "Ming Liu" <eemingliu@hotmail.com>
To: pradeepsampath@yahoo.com, ammubhai@gmail.com
Subject: Re: booting 2.6 kernel on ML403
Date: Fri, 06 Oct 2006 08:24:01 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
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

Hi Pradeep,

>   As soon as i apply the sysace driver and temac drivers and copy the 
xparameters_ml300.h (from EDK) to xparameters_ml403.h all i get is this... 
meaning kernel hangs after displaying "Now booting the kernel".

I have experienced this before. But in my condition, I applied both ACE and 
Temac patches. Ameet said it's a problem of the kernel and the kernel just 
lost the configuration information. So just "make proper" and reconfigure 
your kernel and recompile it. In my condition, it helps. I don't know if it 
is useful to solve your problem. Just try it.

>
>   When i disable sysace and TEMAC drivers, the system goes further till 
"root=" option and then tries to "Kernel Rebooting in 180 seconds". 
Yesterday i tried root=/dev/xsysace2 rw and creating block device files in 
/dev of the CF card. But it ran into the same problem.Is there a sysace 
driver patch that i can apply without applying the TEMAC driver patch?

Don't try root=/dev/xsysace2. In Ameet's driver, he defined as xsa2. So 
just keep consistent with the source code. 

Also, in his website, there are patches which are used without Temac. They 
are not labeled with -after-temac. 

>   So far i was using the EDK 8.1 SP2 (latest) which has the IP core TEMAC 
version 3.00. Now i downgraded to EDK 8.1 to get the version 2.00 (please 
see John Bonesio's post).

I am using TEMAC 1.00. The 3.00 version is totally different with 1.00. So 
I don't know if it is one reason about your problem. 



Regards
Ming

_________________________________________________________________
享用世界上最大的电子邮件系统— MSN Hotmail。  http://www.hotmail.com  
