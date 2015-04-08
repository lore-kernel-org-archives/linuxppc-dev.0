Return-Path: <clg@fr.ibm.com>
Received: from e06smtp16.uk.ibm.com (e06smtp16.uk.ibm.com [195.75.94.112])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 095DD1A0984
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Apr 2015 03:33:51 +1000 (AEST)
Received: from /spool/local
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Wed, 8 Apr 2015 18:33:47 +0100
Message-ID: <55256671.7070209@fr.ibm.com>
Date: Wed, 08 Apr 2015 19:33:37 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5 0/4] hwmon: (ibmpowernv) add DTS support
References: <1428513590-5773-1-git-send-email-clg@fr.ibm.com>
 <20150408173236.GB26109@roeck-us.net>
In-Reply-To: <20150408173236.GB26109@roeck-us.net>
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

On 04/08/2015 07:32 PM, Guenter Roeck wrote:
> On Wed, Apr 08, 2015 at 07:19:46PM +0200, Cédric Le Goater wrote:
>> Hello !
>>
>> These patches extend the ibmpowernv driver to support the new OPAL firmware 
>> which now exposes in its device tree the Digital Temperature Sensors of 
>> a P8 system.
>>
>> They are based on Linux 4.0.0-rc7 + the initial cleanup serie :
>>
>>      http://lists.lm-sensors.org/pipermail/lm-sensors/2015-March/043670.html
>>
>> and were tested on IBM Power and Open Power systems running Trusty.
>>
> Series applied to -next.

Thanks for the review ! 

Cheers

C.
