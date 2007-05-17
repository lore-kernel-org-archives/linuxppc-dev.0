Return-Path: <wfarnsworth@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 7D5F8DDDD5
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 10:09:45 +1000 (EST)
Subject: Re: [PATCH 2/5] Add legacy devices to mpc8641_hpcn.dts
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <0c3907573f12a0731d03335fe3334363@kernel.crashing.org>
References: <1179245829.8132.100.camel@rhino> <1179246470.8132.112.camel@rhino>
	<1179333421.7018.17.camel@ld0161-tx32>
	<b77c4b3dd22795a73cd32a0623722e51@kernel.crashing.org>
	<1179346653.8132.223.camel@rhino>
	<0c3907573f12a0731d03335fe3334363@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 16 May 2007 17:09:42 -0700
Message-Id: <1179360583.8132.234.camel@rhino>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-05-17 at 01:40 +0200, Segher Boessenkool wrote:
> >>>> +				8042@60 {
> >>>> +					device_type = "8042";
> >>
> >> Drop the device_type.  A number as a name isn't
> >> all that great, either.
> >
> > Currently in order for the i8042 devices to be initialized,
> > check_legacy_ioport() must find a node with device_type "8042".
> 
> So fix that :-)

No problem for this platform.  Are there any device trees for other
platforms that use this?

--Wade
