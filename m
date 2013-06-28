Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8DD2F2C00B8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 17:58:37 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 28 Jun 2013 01:58:33 -0600
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 72DE4C90044
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 03:58:29 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5S7wUJE306798
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 03:58:30 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5S7wT88027334
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 03:58:30 -0400
Date: Fri, 28 Jun 2013 15:58:23 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v3] powerpc/eeh: Update MAINTAINERS
Message-ID: <20130628075823.GA31734@shangw.(null)>
References: <1372398143-15561-1-git-send-email-shangw@linux.vnet.ibm.com>
 <20130628174634.3d05e076cbe48ffc4ad67a60@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130628174634.3d05e076cbe48ffc4ad67a60@canb.auug.org.au>
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

On Fri, Jun 28, 2013 at 05:46:34PM +1000, Stephen Rothwell wrote:
>Hi Gavin,
>
>On Fri, 28 Jun 2013 13:42:23 +0800 Gavin Shan <shangw@linux.vnet.ibm.com> wrote:
>>
>> Update MAINTAINERS to reflect recent changes.
>> 
>> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
>> ---
>>  MAINTAINERS |    6 ++++++
>>  1 files changed, 6 insertions(+), 0 deletions(-)
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 5be702c..78e64c9 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -6149,7 +6149,13 @@ M:	Linas Vepstas <linasvepstas@gmail.com>
>>  L:	linux-pci@vger.kernel.org
>>  S:	Supported
>>  F:	Documentation/PCI/pci-error-recovery.txt
>> +
>> +ENHANCED ERROR HANDLING (EEH)
>> +M:	Gavin Shan <shangw@linux.vnet.ibm.com>
>> +L:	linuxppc-dev@lists.ozlabs.org
>> +S:	Supported
>>  F:	Documentation/powerpc/eeh-pci-error-recovery.txt
>> +F:	arch/powerpc/kernel/eeh*.c
>>  
>>  PCI SUBSYSTEM
>>  M:	Bjorn Helgaas <bhelgaas@google.com>
>
>The entries in the MAINTAINERS file are meant to be in alphabetical
>order ...
>

Thanks, Stephen :-)

I'll send up an v4. Sorry for my noise ;-(

Thanks,
Gavin
