Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc3-s30.bay0.hotmail.com (bay0-omc3-s30.bay0.hotmail.com
	[65.54.246.230]) by ozlabs.org (Postfix) with ESMTP id 25AA067C37
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  4 Oct 2006 18:11:58 +1000 (EST)
Message-ID: <BAY110-F1626C56882856AE74835E5B21D0@phx.gbl>
In-Reply-To: <20061003214641.48214.qmail@web83210.mail.mud.yahoo.com>
From: "Ming Liu" <eemingliu@hotmail.com>
To: pradeepsampath@yahoo.com
Subject: Re: booting 2.6 kernel on ML403
Date: Wed, 04 Oct 2006 08:11:52 +0000
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

Hi,

>   [    3.093694] TCP bic registered
>[    3.129458] NET: Registered protocol family 8
>[    3.181412] NET: Registered protocol family 20
>[    3.236744] VFS: Cannot open root device "xsa2" or unknown-block(0,0)
>[    3.313092] Please append a correct "root=" boot option

It looks that some errors still exist in the parameters you passed to 
"root=". Please double check it, or post it in the maillist for deep 
analysis. 

Regards
Ming

_________________________________________________________________
享用世界上最大的电子邮件系统— MSN Hotmail。  http://www.hotmail.com  
