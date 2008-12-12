Return-Path: <jwboyer@gmail.com>
Received: from mail-gx0-f19.google.com (mail-gx0-f19.google.com
	[209.85.217.19]) by ozlabs.org (Postfix) with ESMTP id A1777DE092
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Dec 2008 12:09:47 +1100 (EST)
Received: by gxk12 with SMTP id 12so1601176gxk.9
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 17:09:28 -0800 (PST)
Sender: Josh Boyer <jwboyer@gmail.com>
Date: Thu, 11 Dec 2008 20:03:22 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Problem building kernel
Message-ID: <20081212010322.GB30711@yoda.jdub.homelinux.org>
References: <683138.71397.qm@web83507.mail.sp1.yahoo.com>
	<EE58AED7-C014-4009-ADB8-F8D5AC0B6221@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <EE58AED7-C014-4009-ADB8-F8D5AC0B6221@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Ron Madrid <ron_madrid@sbcglobal.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 11, 2008 at 06:19:20PM -0600, Kumar Gala wrote:
>
> On Dec 11, 2008, at 5:48 PM, Ron Madrid wrote:
>
>> Hello all,
>>
>> I got the latest kernel from git://git.denx.de/linux-2.6-denx.git and 
>> after
>> configuring with menuconfig I am seeing these errors.  I feel like  
>> this
>> could be something simple that I am just unaware of, but I'm not sure
>> and haven't been able to find anything useful when doing a web search.
>>
>> Any ideas?  What other information would be helpful?
>>
>>  BOOTCC  arch/powerpc/boot/redboot-83xx.o
>>  BOOTCC  arch/powerpc/boot/cuboot-sam440ep.o
>>  BOOTCC  arch/powerpc/boot/cuboot-acadia.o
>> {standard input}: Assembler messages:
>> {standard input}:278: Error: Unrecognized opcode: `mtdcr'
>> {standard input}:282: Error: Unrecognized opcode: `mfdcr'
>> {standard input}:289: Error: Unrecognized opcode: `mtdcr'
>> {standard input}:293: Error: Unrecognized opcode: `mfdcr'
>> {standard input}:312: Error: Unrecognized opcode: `mtdcr'
>> {standard input}:316: Error: Unrecognized opcode: `mfdcr'
>> make[2]: *** [arch/powerpc/boot/cuboot-acadia.o] Error 1
>> make[1]: *** [zImage] Error 2
>> make: *** [sub-make] Error 2
>>
>> Ron
>
> I swear Josh or Grant fixed this.

I did.  I sent a pull request to Paul today for this exact commit.

I had it sitting in the wrong branch of my tree.  Sorry about that.

josh
