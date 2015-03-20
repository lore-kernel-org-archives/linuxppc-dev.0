Return-Path: <clg@fr.ibm.com>
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 03F551A2A94
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2015 03:52:46 +1100 (AEDT)
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Fri, 20 Mar 2015 16:52:43 -0000
Message-ID: <550C5056.4030603@fr.ibm.com>
Date: Fri, 20 Mar 2015 17:52:38 +0100
From: Cedric Le Goater <clg@fr.ibm.com>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 0/5] hwmon: (ibmpowernv) remove dependency on OPAL index
References: <1423117857-32759-1-git-send-email-clg@fr.ibm.com>
 <1426787085-9004-1-git-send-email-clg@fr.ibm.com>
 <20150320152611.GA10749@roeck-us.net>
In-Reply-To: <20150320152611.GA10749@roeck-us.net>
Content-Type: text/plain; charset=windows-1252
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, lm-sensors@lm-sensors.org,
 Neelesh Gupta <neelegup@linux.vnet.ibm.com>, skiboot@lists.ozlabs.org,
 linuxppc-dev@lists.ozlabs.org, Jean Delvare <jdelvare@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/20/2015 04:26 PM, Guenter Roeck wrote:
> On Thu, Mar 19, 2015 at 06:44:40PM +0100, Cédric Le Goater wrote:
>> Hello !
>>
>> The current implementation of the driver uses an index for the hwmon 
>> attribute which is extracted from the device node name. This index
>> is calculated by the OPAL firmware and its usage creates a dependency 
>> with the driver which makes changes a little more complex in OPAL.
>>
>> This patchset changes the ibmpowernv code to use its own index. It 
>> starts with a few cleanups, mostly code shuffling around the creation 
>> of the hwmon sysfs attributes and completes by removing the dependency.
>>
> Series applied to hwmon-next (with patch #4 fixed up).

Thanks !

C.
