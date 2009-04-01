Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from SG2EHSOBE002.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80]) by ozlabs.org (Postfix) with ESMTP id 701B7DDDFA
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 11:45:52 +1100 (EST)
Message-ID: <49D2B928.2070603@am.sony.com>
Date: Tue, 31 Mar 2009 17:45:28 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: kexec: proc/device-tree/chosen/linux,kernel-end: No such file
	or directory
References: <alpine.LRH.2.00.0903311808310.32461@vixen.sonytel.be>
	<1238543571.6522.12.camel@localhost>
In-Reply-To: <1238543571.6522.12.camel@localhost>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 03/31/2009 04:52 PM, Michael Ellerman wrote:
> On Tue, 2009-03-31 at 18:25 +0200, Geert Uytterhoeven wrote:
>> With today's kernel, I can no longer kexec any kernel on PS3:
>> 
>> | /proc/device-tree/chosen/linux,kernel-end: No such file or directory
>> | Could not get memory layout
>> 
>> Today's bad version: 15f7176eb1cccec0a332541285ee752b935c1c85
>> Yesterday's good version: 0d34fb8e93ceba7b6dad0062dbb4a0813bacd75b
>> 
>> Before I start bisecting (tomorrow or the day thereafter), anyone with an idea?
> 
> Hmm, not really.
> 
> Looking at the code the only obvious way you could end up without that
> property is if you didn't have a /chosen?

We got one, but linux,kernel-end isn't there anymore.  Was before.

# ls /proc/device-tree/chosen/
name
# 
