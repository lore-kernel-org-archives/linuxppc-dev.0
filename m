Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <dc3d7701e701266ffe852acf4da127ed@kernel.crashing.org>
References: <dc3d7701e701266ffe852acf4da127ed@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3F1564F6-3732-403B-BA6B-BFAB28568AEE@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Tue, 9 Aug 2005 09:12:20 -0500
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Joel Schopp <jschopp@austin.ibm.com>, linuxppc64-dev@ozlabs.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
Subject: Re: Merging ppc32 and ppc64
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 9, 2005, at 8:30 AM, Segher Boessenkool wrote:

>>>>> I don't see the merge as changing the actual code that gets
>>>>>
> executed
>
>>>>> on any given platform very much, except in one respect: we are
>>>>>
> going
>
>>>>> to standardize on a flattened device tree as the way that
>>>>> information
>>>>> about the platform gets passed from the boot loader to the kernel.
>>>>>
>>
>> ^^^^^^^^^^^^^^^^^^^^^***********^^^^^^^^******^
>>
>
> Yes, and that is exactly what I do not want.  We are not going
> to require OF implementations that do not need yaboot or similar
> to pass a flattened device tree to the kernel, eh?  Also, there
> is no reason why something like yaboot (with an OF still running
> underneath) should have to care about anything device-tree related
> at all; the OS can just as easily ask the OF itself.

I was under the impression that ALL platforms regardless if the had a  
OF firmware or not would be using a flattened device tree.  Any  
conversion between an OF tree to a flatten tree would end up  
happening in boot wrapper code going forward.

- kumar
