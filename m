Return-Path: <nfont@austin.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 34115DDF90
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 23:54:49 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m61Dsaiq015926
	for <linuxppc-dev@ozlabs.org>; Tue, 1 Jul 2008 09:54:36 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m61DsQxK225398
	for <linuxppc-dev@ozlabs.org>; Tue, 1 Jul 2008 09:54:26 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m61DsQmk017548
	for <linuxppc-dev@ozlabs.org>; Tue, 1 Jul 2008 09:54:26 -0400
Message-ID: <486A3710.6070106@austin.ibm.com>
Date: Tue, 01 Jul 2008 08:54:24 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 4/5] Helper routines for parsing drconf memory
References: <485C2033.20101@austin.ibm.com>	<485C226B.6050807@austin.ibm.com>
	<18536.54376.368328.736714@cargo.ozlabs.ibm.com>
In-Reply-To: <18536.54376.368328.736714@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> Nathan Fontenot writes:
> 
>> This patch pulls several pieces of exisitng code for parsing memory under
>> the ibm,dynamic-reconfiguration-memory node of the device tree into helper
>> routines.  This is in preparation for the next patch that will also use these
>> same helper routines.  There are no functional changes in this patch.
> 
> I went to apply this, but it is whitespace-damaged...
> 

Hmmm... I am having problems getting this to apply to the latest mainline cleanly.
I'll update the patchset and re-submit.

-Nathan
