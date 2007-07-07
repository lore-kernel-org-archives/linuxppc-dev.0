Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 9AFE6DE186
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Jul 2007 04:27:38 +1000 (EST)
Message-ID: <468FDB8F.4050007@ru.mvista.com>
Date: Sat, 07 Jul 2007 22:29:35 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/5] Add legacy devices to mpc8641_hpcn.dts
References: <1179245829.8132.100.camel@rhino>
	<1179246470.8132.112.camel@rhino>	<1179333421.7018.17.camel@ld0161-tx32>
	<b77c4b3dd22795a73cd32a0623722e51@kernel.crashing.org>
In-Reply-To: <b77c4b3dd22795a73cd32a0623722e51@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Segher Boessenkool wrote:
>>>+			isa@f0 {

> isa@1e

>>>+				8042@60 {
>>>+					device_type = "8042";

> Drop the device_type.  A number as a name isn't
> all that great, either.

   Yet it's kinda accepted years ago, see:

http://playground.sun.com/1275/proposals/Closed/Accepted/381-it.txt

    Ugh, it's hard to find these documents... All "name", "device_type", and 
"compatible" must all be "8042".

> Segher

WBR, Sergei
