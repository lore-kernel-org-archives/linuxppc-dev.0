Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 60036B6F14
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Sep 2010 07:00:17 +1000 (EST)
To: Rupjyoti Sarmah <rsarmah@apm.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: drivers/ata/sata_dwc_460ex.c fails to build
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <5205dc59ca0e0fd65e50d80eeff60d01@mail.gmail.com>
References: <20100818205646.57783157D71@gemini.denx.de>
	<20100902061423.19D66153A79@gemini.denx.de>
	607f1313d8b49e06cf3d2f74b8925732@mail.gmail.com
	<5205dc59ca0e0fd65e50d80eeff60d01@mail.gmail.com>
Date: Tue, 07 Sep 2010 23:00:13 +0200
Message-Id: <20100907210013.9B9121506AA@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org, Prodyut Hazarika <phazarika@appliedmicro.com>,
	Mark Miesfeld <mmiesfeld@appliedmicro.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Rupjyoti Sarmah,

In message <5205dc59ca0e0fd65e50d80eeff60d01@mail.gmail.com> you wrote:
> 
> The current mainline 2.6.36-rc3 does not report any error while building
> the SATA driver.

It reports a lot of warnings, though:

-> git describe
v2.6.36-rc3
In file included from drivers/ata/sata_dwc_460ex.c:38:
drivers/ata/libata.h:31:1: warning: this is the location of the previous definition
drivers/ata/sata_dwc_460ex.c:44:1: warning: "DRV_VERSION" redefined
drivers/ata/libata.h:32:1: warning: this is the location of the previous definition
drivers/ata/sata_dwc_460ex.c: In function 'sata_dwc_exec_command_by_tag':
drivers/ata/sata_dwc_460ex.c:1356: warning: passing argument 1 of 'ata_get_cmd_descript' makes integer from pointer without a cast
drivers/ata/sata_dwc_460ex.c: In function 'sata_dwc_qc_issue':
drivers/ata/sata_dwc_460ex.c:1476: warning: 'err' is used uninitialized in this function
drivers/ata/sata_dwc_460ex.c:1465: note: 'err' was declared here
drivers/scsi/constants.c: In function 'scsi_print_sense':
drivers/scsi/constants.c:1407: warning: zero-length printf format string
drivers/scsi/constants.c:1413: warning: zero-length printf format string
drivers/scsi/constants.c: In function 'scsi_print_result':
drivers/scsi/constants.c:1456: warning: zero-length printf format string
drivers/scsi/sd.c: In function 'sd_print_sense_hdr':
drivers/scsi/sd.c:2628: warning: zero-length printf format string
drivers/scsi/sd.c:2630: warning: zero-length printf format string
drivers/scsi/sd.c: In function 'sd_print_result':
drivers/scsi/sd.c:2636: warning: zero-length printf format string

And the ``'err' is used uninitialized'' warning is indeed a valid one.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
What is mind?  No matter.  What is matter?  Never mind.
                                      -- Thomas Hewitt Key, 1799-1875
