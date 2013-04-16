Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 176532C0106
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Apr 2013 17:59:53 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Tue, 16 Apr 2013 13:25:07 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id A26B5394005E
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Apr 2013 13:29:45 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3G7xdrs10944964
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Apr 2013 13:29:39 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3G7xiOG015287
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Apr 2013 17:59:45 +1000
Message-ID: <516D04EF.6030803@linux.vnet.ibm.com>
Date: Tue, 16 Apr 2013 13:29:43 +0530
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/8] Read/Write oops nvram partition via pstore
References: <20130410071835.20150.56489.stgit@aruna-ThinkPad-T420>
 <20130410072303.20150.61382.stgit@aruna-ThinkPad-T420>
 <20130415075555.GE30156@concordia> <516CEDB4.9090005@linux.vnet.ibm.com>
 <1366096475.24994.50.camel@pasglop>
In-Reply-To: <1366096475.24994.50.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: jkenisto@linux.vnet.ibm.com, mahesh@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
 anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 16 April 2013 12:44 PM, Benjamin Herrenschmidt wrote:
> On Tue, 2013-04-16 at 11:50 +0530, Aruna Balakrishnaiah wrote:
>> Sure. I will have one #ifdef for declarations and one for function
>> definitions.
> Declarations generally don't need #ifdef's

Sorry by declarations I meant variable declarations (used by pstore) not function
declarations.

> Cheers,
> Ben.
>
>
