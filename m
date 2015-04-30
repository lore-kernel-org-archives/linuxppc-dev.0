Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 846EC1A0099
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 01:09:30 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Fri, 1 May 2015 01:09:28 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id A06C72BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 01:09:25 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3UF9H3T27787502
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 May 2015 01:09:25 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3UF8pQA007215
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 May 2015 01:08:52 +1000
Message-ID: <5542456F.2060904@linux.vnet.ibm.com>
Date: Thu, 30 Apr 2015 20:38:31 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: Re: [PATCH v4 3/3] leds/powernv: Add driver for PowerNV platform
References: <20150428100535.26912.29607.stgit@localhost.localdomain>
 <20150428101008.26912.38735.stgit@localhost.localdomain>
 <55423C45.3070601@samsung.com>
In-Reply-To: <55423C45.3070601@samsung.com>
Content-Type: text/plain; charset=utf-8
Cc: stewart@linux.vnet.ibm.com, j.anaszewski81@gmail.com, cooloney@gmail.com,
 rpurdie@rpsys.net, linuxppc-dev@lists.ozlabs.org, linux-leds@vger.kernel.org,
 khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/30/2015 07:59 PM, Jacek Anaszewski wrote:
> Hi Vasant,
> 

Hi  Jacek,

.../...

>> diff --git a/Documentation/devicetree/bindings/leds/leds-powernv.txt
>> b/Documentation/devicetree/bindings/leds/leds-powernv.txt
>> new file mode 100644
>> index 0000000..6bb0e7e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/leds/leds-powernv.txt
>> @@ -0,0 +1,29 @@
>> +Device Tree binding for LEDs on IBM Power Systems
>> +-------------------------------------------------
>> +
>> +The 'led' node under '/ibm,opal' lists service indicators available in the
>> +system and their capabilities.
>> +
>> +led {
>> +    compatible = "ibm,opal-v3-led";
>> +    phandle = <0x1000006b>;
>> +    linux,phandle = <0x1000006b>;
>> +    led-mode = "lightpath";
>> +
>> +    U78C9.001.RST0027-P1-C1 {
>> +        led-types = "identify", "fault";
>> +        led-loc = "descendent";
>> +        phandle = <0x1000006f>;
>> +        linux,phandle = <0x1000006f>;
>> +    };
>> +    ...
>> +    ...
>> +};
>> +
>> +Each node under 'led' node describes location code of FRU/Enclosure.
>> +
>> +The properties under each node:
>> +
>> +  led-types : Supported LED types (attention/identify/fault).
>> +
>> +  led-loc   : enclosure/descendent(FRU) location code.
> 
> DT documentation it usually constructed so that properties are
> described in the beginning and the file ends with an example.
> 
> Also last time I mistakenly requested to remove description of
> compatible property, but it should also be present here and
> the entry should described it in detail, like:
> 
> - compatible : Should be "ibm,opal-v3-led".

That's fine. I will fix it in v5.

> 
> Please refer to the other bindings,
> 
> I will express my opinion on the LED part after powerpc maintainer
> will ack DT bindings.
> 

Sure..

@Ben/Michael,
  Can you please review/ack this patchset?

-Vasant
