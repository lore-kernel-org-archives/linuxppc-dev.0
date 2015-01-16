Return-Path: <grimm@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 233C91A0D5A
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Jan 2015 06:29:37 +1100 (AEDT)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <grimm@linux.vnet.ibm.com>;
 Fri, 16 Jan 2015 12:29:35 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 0622E3E4003B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jan 2015 12:23:45 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t0GJSIhf32506062
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jan 2015 12:28:18 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0GJTWfS009372
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jan 2015 12:29:32 -0700
Message-ID: <54B9669B.7040300@linux.vnet.ibm.com>
Date: Fri, 16 Jan 2015 14:29:31 -0500
From: Ryan Grimm <grimm@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Ian Munsie <imunsie@au1.ibm.com>
Subject: Re: [PATCH 1/3] CXL: Add image control to sysfs
References: <1421360837-40287-1-git-send-email-grimm@linux.vnet.ibm.com>
 <1421381208-sup-526@delenn.ozlabs.ibm.com>
In-Reply-To: <1421381208-sup-526@delenn.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Cc: mikey <mikey@neuling.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/15/2015 11:15 PM, Ian Munsie wrote:
> Hi Ryan,
>
> Excerpts from Ryan Grimm's message of 2015-01-16 09:27:15 +1100:
>> reset_image_select identifies whether a PERST will cause the image to be
>
> s/reset_image_select/load_image_on_perst/
>

Ah, thanks, fixed.

>> +What:           /sys/class/cxl/<card>/load_image_on_perst
>> +Date:           December 2014
>> +Contact:        linuxppc-dev@lists.ozlabs.org
>> +Description:    read/write
>> +                Value of "none" means PERST will not cause image to be loaded
>> +                to the card.  A power cycle is required to load the image.
>
> git am spotted some whitespace at the end of this line.
>
>

Thanks, fixed again.

>> +int cxl_update_image_control(struct cxl *adapter)
>
> Would you be able to pull this function out into a separate patch (can
> be first in the series so everything still compiles after each patch)
> along with the change to the image_state defaults from patch 3? It's a
> fix that I think would be good to be backported to stable, which will be
> simpler if it's in a separate patch.
>

Good idea.  Yeah, pulling in the change from patch 3 makes sense.

Sure, done.

>
>
> Otherwise, looks good :)

Great, thanks for reviewing!~

-Ryan


>
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>
>
