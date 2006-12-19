Return-Path: <minyard@acm.org>
Received: from mta11.adelphia.net (mta11.adelphia.net [68.168.78.205])
	by ozlabs.org (Postfix) with ESMTP id E9828DDF73
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 05:06:26 +1100 (EST)
Message-ID: <45882A20.7030802@acm.org>
Date: Tue, 19 Dec 2006 12:06:24 -0600
From: Corey Minyard <minyard@acm.org>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [Openipmi-developer] [patch 0/1] ipmi: update: add autosensing
	of ipmi devices on powerpc using of device tree
References: <20061218163846.337fed65@localhost>	<20061218164229.6a8b0df7@localhost>	<A45F8443-A031-41AC-887C-669FABBE0F09@kernel.crashing.org>	<200612182323.11262.arnd@arndb.de>
	<8AE62F56-5166-4701-AFF0-04D901EB6FD6@kernel.crashing.org>
In-Reply-To: <8AE62F56-5166-4701-AFF0-04D901EB6FD6@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Christian Krafft <krafft@de.ibm.com>,
	openipmi-developer@lists.sourceforge.net,
	Christian Krafft <krafft@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
>>>> +static int ipmi_of_remove(struct of_device *dev)
>>>> +{
>>>> +     /* should call
>>>> +      * cleanup_one_si(dev->dev.driver_data); */
>>>>         
>>> So fix that :-)
>>>       
>> That should be a separate patch that fixes the same thing for
>> pci ipmi devices as well. It needs to move code around for this
>> (or introduce forward declarations), and the effect is no
>> different, so it's really just a cleanup.
>>     
>
> Oh, this is broken in the existing stuff as well?  Never mind then.
>   
The forward declaration (and changes required for this to work) is in 
Linus' current tree, but was not released in 2.6.19.  So a later patch 
should be fine.

-Corey
