Return-Path: <clg@fr.ibm.com>
Received: from e06smtp18.uk.ibm.com (e06smtp18.uk.ibm.com [195.75.94.114])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 314212C0082
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Mar 2014 04:40:30 +1100 (EST)
Received: from /spool/local
 by e06smtp18.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Fri, 21 Mar 2014 17:40:26 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 27AB9219004D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Mar 2014 17:40:20 +0000 (GMT)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2LHeDbV44826720
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Mar 2014 17:40:13 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2LHeOcS003012
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Mar 2014 11:40:24 -0600
Message-ID: <532C797C.90205@fr.ibm.com>
Date: Fri, 21 Mar 2014 18:40:12 +0100
From: Cedric Le Goater <clg@fr.ibm.com>
MIME-Version: 1.0
To: Geoff Levand <geoff@infradead.org>
Subject: Re: [PATCH 00/18] powerpc/boot: 64bit little endian wrapper
References: <1391788771-16405-1-git-send-email-clg@fr.ibm.com>
 <1395328213-19206-1-git-send-email-clg@fr.ibm.com>
 <1395422919.26958.6.camel@smoke>
In-Reply-To: <1395422919.26958.6.camel@smoke>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/21/2014 06:28 PM, Geoff Levand wrote:
> Hi Cédric,
> 
> On Thu, 2014-03-20 at 16:09 +0100, Cédric Le Goater wrote:
>> The following patchset adds support for 64bit little endian boot 
>> wrapper. It is based on original code from Andrew Tauferner. 
> 
> I tested this on PS3 (64 bit BE) and found no regression.
> 
> Tested by: Geoff Levand <geoff@infradead.org>

Thanks !

C.
