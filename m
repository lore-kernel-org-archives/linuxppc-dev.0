Return-Path: <vwool@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 7F23367C09
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Nov 2006 07:30:01 +1100 (EST)
Subject: Re: [PATCH] adding ROM chips to device tree
From: Vitaly Wool <vwool@ru.mvista.com>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
In-Reply-To: <454A408D.1020503@ru.mvista.com>
References: <20061102145539.f0b8657f.vwool@ru.mvista.com>
	<454A408D.1020503@ru.mvista.com>
Content-Type: text/plain
Date: Thu, 02 Nov 2006 23:30:00 +0300
Message-Id: <1162499400.2592.8.camel@barja>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


>     The set of device properties may vary from driver to driver, anway...

It's pretty easy to define set of properties universal for each type of
flash chips.


>     Hey, you just changed device_type from "mtd" to "rom", do you expect this 
> to still work? :-)

Heh, I've put the updated description in the patch but forgot to re-diff
the rest...


>     And, this actually should be registering *all* devices, not only "physmap" 
> ones. The of_device probing code should figure out which drivers will get 
> which devices.

Fine, I guess you're eager to send a respin of the patch... Feel free
to! :)

Thanks,
  Vitaly
