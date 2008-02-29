Return-Path: <gvb.linuxppc.dev@gmail.com>
Received: from QMTA05.emeryville.ca.mail.comcast.net
	(qmta05.emeryville.ca.mail.comcast.net [76.96.30.48])
	by ozlabs.org (Postfix) with ESMTP id 03E63DDE33
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 13:52:50 +1100 (EST)
Message-ID: <47C773B7.40302@gmail.com>
Date: Thu, 28 Feb 2008 21:53:43 -0500
From: Jerry Van Baren <gvb.linuxppc.dev@gmail.com>
MIME-Version: 1.0
To: jyoung5@us.ibm.com
Subject: Re: [dtc] breaking out libfdt from dtc so other progs can use it
References: <1204141243.18831.12.camel@thinkpad.austin.ibm.com>	<20080228014101.GA24330@localhost.localdomain>	<1204216244.6676.13.camel@thinkpad.austin.ibm.com>	<20080228125940.78f7f2b6@vader.jdub.homelinux.org>
	<1204228953.12181.15.camel@thinkpad.austin.ibm.com>
In-Reply-To: <1204228953.12181.15.camel@thinkpad.austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jerone Young wrote:
> On Thu, 2008-02-28 at 12:59 -0600, Josh Boyer wrote:
>> On Thu, 28 Feb 2008 10:30:44 -0600
>> Jerone Young <jyoung5@us.ibm.com> wrote:

[big snip]

>> You still haven't explained why maintenance is harder or somehow less
>> doable by having it in the dtc repo.  Maintenance is very much the
>> concern of the upstream developers, which seem to be saying it's not a
>> problem for them...
> 
> I guess what I see libfdt as something like shared userspace library. At
> the moment dtc is the only userspace project to use it.  So it make
> perfect since to keep it with the source and not separated.
> 
> Though when other projects need it .. the option of having to try to
> figure out what version of dtc to grab so understand what libfdt is
> usable, can be a bit of a pain.
> 
> Though I can't really argue that you can't get around this by just
> downloading dtc and grabbing out the libfdt package..though it does
> cause some indirection.  

FWIIW, that is what the u-boot project is doing.  The last pass, I 
actually extracted the libfdt git patch(es) and then applied them to the 
u-boot tree so that the history would be carried over.  The libfdt 
portion is now quite stable and I don't see major changes coming that 
would cause this methodology to be a problem.

Best regards,
gvb
