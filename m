Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e32.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8ECA62C0322
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 15:12:59 +1000 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 27 Jun 2013 23:12:56 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id D2BA41FF001F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 23:07:38 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5S5Cs96158644
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 23:12:54 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5S5CskM029969
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 23:12:54 -0600
Date: Fri, 28 Jun 2013 13:12:50 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc/eeh: Update MAINTAINERS
Message-ID: <20130628051250.GA11968@shangw.(null)>
References: <1372386316-24086-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1372395413.18612.58.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1372395413.18612.58.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <shangw@linux.vnet.ibm.com>
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 28, 2013 at 02:56:53PM +1000, Benjamin Herrenschmidt wrote:
>On Fri, 2013-06-28 at 10:25 +0800, Gavin Shan wrote:
>> Update MAINTAINERS to reflect recent changes.
>> 
>> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
>> ---
>>  MAINTAINERS |    7 +++++++
>>  1 files changed, 7 insertions(+), 0 deletions(-)
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 5be702c..c724a3a 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -6149,7 +6149,14 @@ M:	Linas Vepstas <linasvepstas@gmail.com>
>>  L:	linux-pci@vger.kernel.org
>>  S:	Supported
>>  F:	Documentation/PCI/pci-error-recovery.txt
>> +F:	drivers/pci/pcie/aer/
>
>Almost ;-) I still don't think that Linus has anything to do with AER,
>just don't add the above line.
>

Ok. I see and will update :-)

Thanks,
Gavin
