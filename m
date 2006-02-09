Return-Path: <grant.likely@secretlab.ca>
Received: from outbound-mail-34.bluehost.com (outbound-mail-34.bluehost.com
	[70.96.188.154]) by ozlabs.org (Postfix) with SMTP id 7ABEB67A01
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Feb 2006 01:51:07 +1100 (EST)
In-Reply-To: <43EAF5EC.7050204@sbcglobal.net>
References: 43CC5453.3060702@xilinx.com <43EAF5EC.7050204@sbcglobal.net>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <DA9387FF-5F05-4A48-B31E-5C9FEF4F1B8F@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 00/10] Updated ML300 & ML403 patches
Date: Thu, 9 Feb 2006 07:51:05 -0700
To: S. Egbert <s.egbert@sbcglobal.net>
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


On 9-Feb-06, at 12:57 AM, S. Egbert wrote:

>>> Really, this isn't statically defined anyway.  The bootloader
>>> (u-boot or zImage) passes the memory size into the kernel; and in
>>> fact the kernel command line; or the board setup code can restrict
>>> the amount of mem used by the kernel.  XPAR_MEM_* isn't used by the
>>> kernel proper at all.
>>>
>>> - Peter
>>
>> Thanks for the comments.
>>
>> Another issue we need to discuss is if/how to support the xilinx
>> generated BSP in the kernel proper; but I'll leave that for a
>> different email.
>>
>> If there's enough interest; I'll setup another git tree for the  
>> virtex
>> specific patches.
>
> I, for one, am interested in helping with the Virtex specific patches.
> Is there a URL for this?  git://?

The patches have now been accepted into paul's powerpt.git tree.

http://www.kernel.org/git/?p=linux/kernel/git/paulus/ 
powerpc.git;a=summary
