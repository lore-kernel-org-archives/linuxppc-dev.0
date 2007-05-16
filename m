Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 6C333DDEFE
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 06:01:58 +1000 (EST)
Message-ID: <464B638E.4070204@ru.mvista.com>
Date: Thu, 17 May 2007 00:03:26 +0400
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

>>>+				8042@60 {
>>>+					device_type = "8042";

> Drop the device_type.  A number as a name isn't
> all that great, either.

    Perhaps it should be called "keyboard" (and device_type should also be set 
to it) since 8042 is in fact (mostly) a keyboard controller... although it 
also "drives" PS/2 mouse...

>>>+				rtc@70 {
>>>+					device_type = "rtc";
>>>+					reg = <1 70 2>;
>>>+				};

>>Is "rtc" a standard OF device,

> Yes, it is defined in the "Device Support Extensions"
> recommended practice.

    And it also defines "keyboard".

WBR, Sergei
