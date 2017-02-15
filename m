Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vNx552ZMfzDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 10:56:09 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1FNrf0c031350
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 18:56:06 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28mq9gstuc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 18:56:06 -0500
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 16 Feb 2017 09:56:04 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 0FBCB2BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 10:56:02 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1FNtsc639125152
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 10:56:02 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1FNtTLL029004
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 10:55:29 +1100
Subject: Re: [PATCHv4 4/4] MAINTAINERS: Remove powerpc's opal match
To: Jon Derrick <jonathan.derrick@intel.com>
References: <1487195159-12599-1-git-send-email-jonathan.derrick@intel.com>
 <1487195159-12599-5-git-send-email-jonathan.derrick@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>,
 Rafael Antognolli <rafael.antognolli@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
 Scott Bauer <scott.bauer@intel.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 16 Feb 2017 10:55:04 +1100
MIME-Version: 1.0
In-Reply-To: <1487195159-12599-5-git-send-email-jonathan.derrick@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <4e977771-2391-5cef-5571-5710693e0c1b@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 16/02/17 08:45, Jon Derrick wrote:
> PPC's 'opal' match pattern also matches block/sed-opal.c, where it looks
> like the 'arch/powerpc' file pattern should be enough to match powerpc
> opal code by itself. Remove the opal regex pattern from powerpc.
>
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>

It looks like this change will exclude the following PPC OPAL related files:

drivers/tty/hvc/hvc_opal.c - HYPERVISOR VIRTUAL CONSOLE DRIVER (which 
lists linuxppc-dev as the mailing list, doesn't name a maintainer though)

drivers/i2c/busses/i2c-opal.c - I2C SUBSYSTEM

drivers/rtc/rtc-opal.c - REAL TIME CLOCK (RTC) SUBSYSTEM

Documentation/devicetree/bindings/i2c/i2c-opal.txt - I2C SUBSYSTEM, OPEN 
FIRMWARE AND FLATTENED DEVICE TREE BINDINGS

Documentation/devicetree/bindings/powerpc/opal - OPEN FIRMWARE AND 
FLATTENED DEVICE TREE BINDINGS

Documentation/devicetree/bindings/powerpc/opal/oppanel-opal.txt - OPEN 
FIRMWARE AND FLATTENED DEVICE TREE BINDINGS

Documentation/devicetree/bindings/rtc/rtc-opal.txt - OPEN FIRMWARE AND 
FLATTENED DEVICE TREE BINDINGS, REAL TIME CLOCK (RTC) SUBSYSTEM

Documentation/ABI/stable/sysfs-firmware-opal-elog - no other subsystem

Documentation/ABI/stable/sysfs-firmware-opal-dump - no other subsystem


-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
