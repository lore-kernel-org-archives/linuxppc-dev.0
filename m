Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D60272C00DF
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Apr 2013 17:40:11 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Mon, 15 Apr 2013 13:07:02 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 5279E1258023
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Apr 2013 13:11:34 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3F7dwGB51642434
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Apr 2013 13:09:58 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3F7e2l8029535
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Apr 2013 17:40:03 +1000
Message-ID: <516BAECB.8060409@linux.vnet.ibm.com>
Date: Mon, 15 Apr 2013 13:09:55 +0530
From: aruna <aruna@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 1/8] Remove syslog prefix in uncompressed oops text
References: <20130410071835.20150.56489.stgit@aruna-ThinkPad-T420>
 <20130410072100.20150.74661.stgit@aruna-ThinkPad-T420>
 <20130415072027.GA30156@concordia>
In-Reply-To: <20130415072027.GA30156@concordia>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

On Monday 15 April 2013 12:50 PM, Michael Ellerman wrote:
> On Wed, Apr 10, 2013 at 12:51:00PM +0530, Aruna Balakrishnaiah wrote:
>> Removal of syslog prefix in the uncompressed oops text will
>> help in capturing more oops data.
> Why does it help? Does this effect any existing tools?
>
> cheers
>

By setting the (2nd) syslog argument of kmsg_dump_get_buffer() to false,
we omit <n> line prefixes and thereby capture more of the printk buffer.

No this should not effect any existing tools.


Regards,
Aruna
