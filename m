Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7D8CBDDDF6
	for <linuxppc-dev@ozlabs.org>; Tue,  5 May 2009 00:53:43 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n44Encmn003833
	for <linuxppc-dev@ozlabs.org>; Mon, 4 May 2009 10:49:38 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n44Ercvk155838
	for <linuxppc-dev@ozlabs.org>; Mon, 4 May 2009 10:53:38 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n44ErcOb023578
	for <linuxppc-dev@ozlabs.org>; Mon, 4 May 2009 10:53:38 -0400
Date: Mon, 4 May 2009 10:52:32 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>, Jean Delvare <khali@linux-fr.org>
Subject: Re: Need a patch tested on a windtunnel powermac
Message-ID: <20090504145232.GB14017@zod.rchland.ibm.com>
References: <18936.58163.872136.772820@cargo.ozlabs.ibm.com>
	<20090430002448.GA5208@hansolo.jdub.homelinux.org>
	<20090430191707.GB2424@yoda.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090430191707.GB2424@yoda.jdub.homelinux.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 30, 2009 at 03:17:08PM -0400, Josh Boyer wrote:
>On Wed, Apr 29, 2009 at 08:24:48PM -0400, Josh Boyer wrote:
>>On Thu, Apr 30, 2009 at 09:30:59AM +1000, Paul Mackerras wrote:
>>>Does anyone here still have a "windtunnel" powermac (PowerMac3,6)
>>>machine running Linux?  We need someone to test Jean Delvare's patch
>>>to the therm_windtunnel driver.  The patch is at:
>>>
>>>http://patchwork.ozlabs.org/patch/26095/
>>>
>>>I don't have a windtunnel machine myself - I have a PowerMac3,5 but
>>>not a PowerMac3,6.
>>
>>I might have one.  I'll pull the G4 I have out of it's box and check tomorrow.
>
>Amazingly enough, I do.  It's running some crusty-arse gentoo install from
>2005, so I need to install something newer on it.  Hopefully that goes smoothly
>today...

Ok, installed 2.6.30-rc4 plus Jean's patch and it appears to do something
correctly:

[jwboyer@localhost macintosh]$ sudo modprobe therm_windtunnel
[jwboyer@localhost macintosh]$ dmesg
<snip>
DS1775 digital thermometer [@49]
Temp: 52.5 C  Hyst: 75.0 C  OS: 80.0 C
ADM1030 fan controller [@2c]
Reducing overheating limit to 65.0 C (Hyst: 60.0 C)
CPU-temp: 52.9 C, Case: 31.3 C,  Fan: 0 (tuned -11)
[jwboyer@localhost macintosh]$ uname -a
Linux localhost.localdomain 2.6.30-rc4 #1 SMP Mon May 4 10:20:39 EDT 2009 ppc ppc ppc GNU/Linux


josh
