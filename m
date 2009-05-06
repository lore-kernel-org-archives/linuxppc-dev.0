Return-Path: <tmorrison@empirix.com>
Received: from empbedexfe.empirix.com (empbedexfe.empirix.com [12.38.203.54])
	by ozlabs.org (Postfix) with ESMTP id 493EEDDDA1
	for <linuxppc-dev@ozlabs.org>; Wed,  6 May 2009 10:06:24 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: MSR_SPE - being turned off...
Date: Tue, 5 May 2009 20:07:20 -0400
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D90110C94509@EMPBEDEX.empirix.com>
In-Reply-To: <756DA1CE-4951-4087-9F1B-FE83A53BB253@kernel.crashing.org>
References: <BD261180E6D35F4D9D32F3E44FD3D90110C30B99@EMPBEDEX.empirix.com>
	<D54110FD-25F0-4A58-9C73-F08D4AE43751@kernel.crashing.org>
	<BD261180E6D35F4D9D32F3E44FD3D90110C30D34@EMPBEDEX.empirix.com>
	<756DA1CE-4951-4087-9F1B-FE83A53BB253@kernel.crashing.org>
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

Ok...taken out...

>> -----Original Message-----
>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>> Sent: Tuesday, May 05, 2009 5:18 PM
>> To: Morrison, Tom
>> Cc: linuxppc-dev@ozlabs.org; Michael Neuling
>> Subject: Re: MSR_SPE - being turned off...
>>=20
>>=20
>> On May 5, 2009, at 7:56 AM, Morrison, Tom wrote:
>>=20
>> > Hi Kumar/Michael...
>> >
>> > Sorry, I really didn't explain myself very well...
>> >
>> > The Problem (answer to Michael):
>> > =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>> > We started using a new compiler that upon -O2 optimization - added
>> > heavy SPE related instructions into our applications (where the
older
>> > compiler might not use as many). Once this was done, we started
>> > experiencing problems with data being 'shifted' and/or corrupted
>> > throughout the applications which didn't immediately cause
problems,
>> > but either scribbled on someone else's memory and/or bad results...
>> > We knew where one of the offending scribbles started (by the
shifting
>> > by 1 byte of a structure) and found by comparing binaries with
'older'
>> > compiler vs. this one that the only major difference was the
'density'
>> > of the SPE instructions...
>> >
>> > As to your question, Kumar:
>> > =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>> > Naively, I explicitly enabled the SPE in a BSP 'early_init' program
>> > (as well as enabling Machine Checks) - which is what I meant by
>> > Enabling SPE...
>>=20
>> Are you setting MSR_SPE in your own board code?  If so stop doing so.
>> There isn't any need or reason to be doing that.  MSR_SPE will get
set
>> when an application starts using SPE code and the kernel will manage
>> it properly.
>>=20
>> - k
>>=20
