Return-Path: <dwm@austin.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B3E1A679FB
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Apr 2006 05:12:35 +1000 (EST)
Received: from e6.ny.us.ibm.com ([192.168.1.106])
	by pokfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k34IuD1g009406
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Apr 2006 14:56:13 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k34Itslu008896
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Apr 2006 14:55:54 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k34Itfqj171178
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Apr 2006 14:55:41 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k34ItcxR014262
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Apr 2006 14:55:38 -0400
Message-Id: <200604041855.k34ItP00022551@falcon10.austin.ibm.com>
In-reply-to: <20060404183442.GA25986@suse.de> 
To: Olaf Hering <olh@suse.de>
Subject: Re: [PATCH] powerpc: iSeries has only 256 IRQs 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 04 Apr 2006 13:55:25 -0500
From: Doug Maxey <dwm@austin.ibm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, paulus@samba.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 04 Apr 2006 20:34:42 +0200, Olaf Hering wrote:
>Great news is that 2.6.5 does it that way:
>
>nst-sys:/ # modprobe  -v lpfc
>insmod /lib/modules/2.6.5-override-iseries64/initrd/scsi_transport_fc.ko 
>insmod /lib/modules/2.6.5-override-iseries64/initrd/lpfc.ko 
>Kernel panic: PCI: Hardware I/O Error, SRC B6000103, Automatic Reboot Disabled.
> 

What firmware level?

++doug
