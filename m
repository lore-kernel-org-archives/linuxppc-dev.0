Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vHSbj4VCkzDqBN
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 13:15:13 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Greg KH <greg@kroah.com>, Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org,
 ukrishn@linux.vnet.ibm.com, vaibhav@linux.vnet.ibm.com,
 fbarrat@linux.vnet.ibm.com, imunsie@au1.ibm.com
Subject: Re: [v2] cxl: prevent read/write to AFU config space while AFU not
 configured
In-Reply-To: <20170206094356.GA8583@kroah.com>
References: <3v8g1Z5Gdyz9t5m@ozlabs.org>
 <1914c3dc-7e4d-30de-88b0-7959e6249f39@au1.ibm.com>
 <f3a508e9-3c23-f929-7b81-fd803c920095@au1.ibm.com>
 <20170206094356.GA8583@kroah.com>
Date: Tue, 07 Feb 2017 13:15:13 +1100
Message-ID: <87lgtig30u.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Greg KH <greg@kroah.com> writes:

> On Mon, Feb 06, 2017 at 12:15:59PM +1100, Andrew Donnellan wrote:
>> On 27/01/17 11:57, Andrew Donnellan wrote:
>> > On 27/01/17 11:40, Michael Ellerman wrote:
>> > > Applied to powerpc next, thanks.
>> > > 
>> > > https://git.kernel.org/powerpc/c/14a3ae34bfd0bcb1cc12d55b06a858
>> > 
>> > Will fix the remaining locking issue in a follow up patch...
>> 
>> Stable team - please make sure this doesn't go in without
>> http://patchwork.ozlabs.org/patch/724315/ once that's merged.
>
> Ok, hopefully they show up in Linus's tree at the same time :)

Yeah they will.

cheers
