Return-Path: <tmorrison@empirix.com>
Received: from empbedexfe.empirix.com (empbedexfe.empirix.com [12.38.203.54])
	by ozlabs.org (Postfix) with ESMTP id C1129DDDFA
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 05:32:48 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: MSR_SPE - being turned off... 
Date: Wed, 6 May 2009 15:33:53 -0400
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D90110CDA4ED@EMPBEDEX.empirix.com>
In-Reply-To: <62217899-08C0-473A-8784-DEEC64A145DD@kernel.crashing.org>
References: <BD261180E6D35F4D9D32F3E44FD3D90110C30B99@EMPBEDEX.empirix.com>
	<D54110FD-25F0-4A58-9C73-F08D4AE43751@kernel.crashing.org>
	<BD261180E6D35F4D9D32F3E44FD3D90110C30D34@EMPBEDEX.empirix.com>
	<13221.1241568099@neuling.org>
	<BD261180E6D35F4D9D32F3E44FD3D90110C94528@EMPBEDEX.empirix.com>
	<B5440F25-74DB-46BB-9374-837441826097@kernel.crashing.org>
	<BD261180E6D35F4D9D32F3E44FD3D9010EEBF67D@EMPBEDEX.empirix.com>
	<343F1A10-459E-4024-B0DD-ADB1D6DCDB9D@kernel.crashing.org>
	<BD261180E6D35F4D9D32F3E44FD3D90110C94615@EMPBEDEX.empirix.com>
	<62217899-08C0-473A-8784-DEEC64A145DD@kernel.crashing.org>
From: "Morrison, Tom" <tmorrison@empirix.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

After sitting with the developer of the application for a while, we may
have=20
two separate issues...

a) Alignment (aka: alignment exceptions) - Looking at how it handles it=20
    And attempts to=20

b) For aligned data - we still contend that if you have enough tasks
working

>> -----Original Message-----
>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>> Sent: Wednesday, May 06, 2009 8:44 AM
>> To: Morrison, Tom
>> Cc: Michael Neuling; linuxppc-dev@ozlabs.org
>> Subject: Re: MSR_SPE - being turned off...
>>=20
>> Can you describe the # of processes you are running in your test.  Is
>> it possible for you to try the tests w/2.6.29 from kernel.org?
>>=20
>> - k
>>=20
>> On May 6, 2009, at 7:42 AM, Morrison, Tom wrote:
>>=20
>> > I'm sorry I forgot to put that, this issue was found with our
>> > currently running kernel 2.6.23.final (what comes with the
>> > Freescale LTIB BSP package dated 05/23/2009).
>> >
>> > I am sorry if I don't understand your statement that the SMP might
>> > be broken on this kernel, because I tried to analyze the kernel
that
>> > came with the latest BSP LTIB [ackage from Freescale (dated
12/18/2009
>> > (where we got the 4.2.171 compiler from)), and the associated
'switch
>> > context' code is exactly the same. Unfortunately, I have not
started
>> > the process of porting my current platform's BSP to this new kernel
-
>> > otherwise, I would have done the test on that platform (this also
>> > requires a new version of u-boot in order to test correctly))..
>> >
>> > I may have mis-interpreted something and/or I am sure I don't
>> > understand everything about the SMP resource management (and
>> > associated SPE management), so thank you for any insight you
>> > may have on this front...
>> >
>> > Tom
>> >
>> >>> -----Original Message-----
<snip other emails>
