Return-Path: <gil_madar@radwin.com>
Received: from mx100.qos.net.il (mx100.qos.net.il [80.74.96.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5EE1D687E9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Nov 2005 20:52:59 +1100 (EST)
Message-ID: <8A7F0BC83EA32C4BBEE5502F0E3D5E6F08E4B1@radwin-mail.radwin.ltd.com>
From: Gil Madar <gil_madar@radwin.com>
To: "'Wolfgang Denk'" <wd@denx.de>, gil-ad@myrealbox.com
Date: Tue, 29 Nov 2005 10:41:56 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: RE: Problem running kernel 2.6.14 (DENX) on MPC866 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Thanks for your reply Wolfgang!

	From: Wolfgang Denk [mailto:wd@denx.de]
	Sent: Tuesday, November 29, 2005 10:09 AM

	> 
	> I load linux from u-boot, and manage to go all the way until the
call to cpu_idle() from rest_init().
	> The system claims mounts a root file system over NFS. Sniffer logs
and host logs support this claim.
	> If I do a while ( 1 ) printk( whatever ), just before cpu_idle(),
the system continues to run.
	> If I let it call cpu_idle(), the system hangs.
	
	For 8xx you could / should use the kernel.org tree. We don't use
2.6
	on 8xx yet.

I will try that. 

	> U-Boot 1.1.3 (Nov 22 2005 - 00:26:43)
	> 
	> CPU:   unknown MPC86x (0x08010004) at 133 MHz: 16 kB I-Cache 8 kB
D-Cache FEC present
	>          *** Warning: CPU Core has Silicon Bugs -- Check the
Errata ***
	
	You should fix this.

OK.

	> Monitor Command Prompt:>setenv gatewayip 10.0.0.138;setenv ethaddr
00:01:02:03:04:05; setenv console ttyCPM0,38400n8; setenv
	
	You use an illegal MAC address; please read the FAQ, especially
	http://www.denx.de/wiki/view/DULG/EthernetDoesNotWork  and
	http://www.denx.de/wiki/view/DULG/WhereCanIGetAValidMACAddress

The ethernet address is ok. not mine, but legal ;-) I checked at
standards.ieee.org:
				 
00-01-02   (hex)		3COM CORPORATION
000102     (base 16)		3COM CORPORATION
				5400 Bayfront Plaza  - MS: 4220
				Santa Clara CA 95052
				UNITED STATES

Thanks for your time,
Gil
