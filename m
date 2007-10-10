Return-Path: <Antonio.DiBacco@technolabs.it>
Received: from smtp.technolabs.it
	(host20-155-static.82-213-b.business.telecomitalia.it
	[213.82.155.20]) by ozlabs.org (Postfix) with ESMTP id 66722DDF4C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Oct 2007 23:01:18 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Linux 'reboot' is HRESET or SRESET on MPC880?
Date: Wed, 10 Oct 2007 14:49:00 +0200
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8EAF3F1D@aquib01a>
In-Reply-To: <200258.92901.qm@web63911.mail.re1.yahoo.com>
From: "DI BACCO ANTONIO - technolabs" <Antonio.DiBacco@technolabs.it>
To: "melinda develey" <melinda.develey70@yahoo.com>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> I need to know if the linux reboot command performs a HRESET or
SRESET. I would like to preserve
> the direction and status of my GPIO pins and then I would like to
perform an SRESET that=20
> shouldn't touch the pddat, pddir.

The mpc8xx restart consists in clearing the ME bit in MSR register to
cause checkstop on machine check and then accessing an invalid location.
I don't know if this causes a SRESET or HRESET and if the GPIO will be
preserved or not. I know that PDDAT, PDDIR and the like are preserved
with SRESET.=20

Bye.




P.S: Please don't post html messages!=20
Do you know me? I see that you greeted me in your mail.
