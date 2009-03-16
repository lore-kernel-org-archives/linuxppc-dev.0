Return-Path: <takatz@pericle.com>
Received: from xceltech.net (mail2.xceltech.net [199.227.119.213])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9896BDDF00
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2009 01:40:21 +1100 (EST)
Message-ID: <49BE64C9.2000104@pericle.com>
Date: Mon, 16 Mar 2009 08:40:09 -0600
From: Mark Takatz <takatz@pericle.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: use generic	pci_assign_unassign_resources
References: %(message_id_url)s <49BAE147.4060102@pericle.com>
	<1237161414.25062.105.camel@pasglop>
In-Reply-To: <1237161414.25062.105.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Robert Wuest <rwuest@wuest.org>
Reply-To: Mark Takatz <takatz@pericle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hehe, and that opens up an entirely different can of worms with our board.

Thanks, however.

Mark

Benjamin Herrenschmidt wrote:
> On Fri, 2009-03-13 at 16:42 -0600, Mark Takatz wrote:
>   
>> Ben,
>>
>> We're looking at the fixes you put in place for the various PCI errors 
>> and we think this is the solution we need for our system, a GE Fanuc CM6 
>> PPC board (single 8641), but your patches appear to apply either to 
>> 2.6.24 or 2.6.25, and we have 2.6.23.  Do you know of any similar work 
>> done on the 2.6.23 release?
>>
>> Thanks in advance for any help you can provide,
>>     
>
> No, you would have to backport major chunks of the PCI rework I did in
> between, along with fixes I did after that. At this stage I would
> recommend considering an update to 2.6.27 or 2.6.28.
>
> Cheers,
> Ben.
>
>
>
>   

-- 
Mark J. Takatz
Pericle Communications Company
1910 Vindicator Drive, Suite 100
Colorado Springs, CO 80919
Office:  (719) 548-1170
Cell:  (719) 287-5267
Fax:  (719) 548-1211
takatz@pericle.com
