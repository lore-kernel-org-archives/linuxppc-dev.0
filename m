Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F8A21A0C50
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2015 01:54:54 +1000 (AEST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Mon, 20 Apr 2015 21:24:51 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 9FA36E0045
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 21:27:25 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3KFslic65994844
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 21:24:47 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3KFslUP027864
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 21:24:47 +0530
Message-ID: <55352145.8060205@linux.vnet.ibm.com>
Date: Mon, 20 Apr 2015 21:24:45 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: Re: [PATCH v3 1/3] powerpc/powernv: Add OPAL interfaces for accessing
 and modifying system LED states
References: <20150420075558.12371.6697.stgit@localhost.localdomain>
 <20150420075927.12371.59080.stgit@localhost.localdomain>
 <55351969.2020604@samsung.com>
In-Reply-To: <55351969.2020604@samsung.com>
Content-Type: text/plain; charset=utf-8
Cc: stewart@linux.vnet.ibm.com, cooloney@gmail.com, rpurdie@rpsys.net,
 linuxppc-dev@lists.ozlabs.org, linux-leds@vger.kernel.org,
 khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/20/2015 08:51 PM, Jacek Anaszewski wrote:
> Hi Vasant, Anshuman,
> 

Jacek,


.../...

>> +
>> +/* LED location */
>> +#define LED_LOC_ENCLOSURE    "enclosure"
>> +#define LED_LOC_DESCENDENT    "descendent"
> 
> These macros should also have POWERNV_LED prefix.

Oh yeah.. I should fix this as well. Will fix in next version.

-Vasant
