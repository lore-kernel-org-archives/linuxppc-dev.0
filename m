Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.62.0508091510400.28068@numbat.sonytel.be>
References: <17136.13558.773102.465379@cargo.ozlabs.ibm.com>
	<42F79D89.3040709@austin.ibm.com>
	<bb9b1e9e1ebdc3ac5b23b3cab327bfd5@kernel.crashing.org>
	<Pine.LNX.4.62.0508091510400.28068@numbat.sonytel.be>
Mime-Version: 1.0 (Apple Message framework v622)
Message-Id: <dc3d7701e701266ffe852acf4da127ed@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Tue, 9 Aug 2005 15:30:42 +0200
To: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: Joel Schopp <jschopp@austin.ibm.com>, linuxppc64-dev@ozlabs.org,
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

>>>> I don't see the merge as changing the actual code that gets executed
>>>> on any given platform very much, except in one respect: we are going
>>>> to standardize on a flattened device tree as the way that 
>>>> information
>>>> about the platform gets passed from the boot loader to the kernel.
>                          
> ^^^^^^^^^^^^^^^^^^^^^***********^^^^^^^^******^

Yes, and that is exactly what I do not want.  We are not going
to require OF implementations that do not need yaboot or similar
to pass a flattened device tree to the kernel, eh?  Also, there
is no reason why something like yaboot (with an OF still running
underneath) should have to care about anything device-tree related
at all; the OS can just as easily ask the OF itself.


Segher
