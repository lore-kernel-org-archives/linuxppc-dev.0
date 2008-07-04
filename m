Return-Path: <neko@genesi-usa.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by ozlabs.org (Postfix) with ESMTP id 6F5BCDDF9E
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 23:34:00 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so725473ugf.0
	for <linuxppc-dev@ozlabs.org>; Fri, 04 Jul 2008 06:33:57 -0700 (PDT)
Message-ID: <486E26C0.9060604@genesi-usa.com>
Date: Fri, 04 Jul 2008 14:33:52 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: New fsl device bindings file
References: <40B88BFD-1FEB-4E36-9917-54C7380FF801@kernel.crashing.org>
	<20080703185312.GA6043@polina.dev.rtsoft.ru>
In-Reply-To: <20080703185312.GA6043@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> On Thu, Jul 03, 2008 at 01:20:18PM -0500, Kumar Gala wrote:
>> Guys,
> 
> 	/* deprecated; */
> 	device_type = "i2c";

How about "deprecated but kept for compatibility with true Open Firmware
implementations"?

Seriously, you can't have a binding for "OF" and then cut out that part of the
standard at a whim. It should be there (at least for those parts which are
governed by a client interface API, like display, serial etc. but cutting it
off takes away all it's meaning, plus Linux implementations STILL keep searching
that property along with "compatible", and probably will for all time that
real IEEE1275 bindings are in use), and if it's not, then what used to go into
there needs to be in compatible.

As a nit, I don't think making it into an example makes the documentation any better
to read at all, in fact I found it harder to read. You may as well throw away all
the docs altogether and produce a well-commented example set if that is the route
this is going down. I think having everything as a plaintext file, while nice and
accessible for everyone, might have something to do with that though.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
