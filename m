Return-Path: <bwarren@qstreams.com>
Received: from smtp103.biz.mail.mud.yahoo.com (smtp103.biz.mail.mud.yahoo.com
	[68.142.200.238]) by ozlabs.org (Postfix) with SMTP id CF3D167C1E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Aug 2006 00:44:59 +1000 (EST)
Subject: Re: CompactFlash on PQII Pro
From: Ben Warren <bwarren@qstreams.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <AB150E9C-6BB3-46C1-980D-311D3277BFC1@kernel.crashing.org>
References: <1156371402.17977.21.camel@saruman.qstreams.net>
	<AB150E9C-6BB3-46C1-980D-311D3277BFC1@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 10:44:55 -0400
Message-Id: <1156430695.17977.28.camel@saruman.qstreams.net>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Reply-To: bwarren@qstreams.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks Kumar,

As always, you're several steps ahead of me.

On Wed, 2006-08-23 at 18:04 -0500, Kumar Gala wrote:

> I know I posted a patch for cf-ide.c to lkml some time ago, this was  
> to do a CF in true ide mode using the 83xx localbus.
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=113877891224982&w=2
> 
> We did some UPM setup in u-boot to use two CS on Localbus for this.
In our case, we only have one CS available but it's going to a CPLD that
will decode and provide two CSs to the CF.  This will work as long as
the UPM setup is identical for the two chip selects.  Should be...  
Off-topic to this list, but do you have the U-boot code that you can
share?  If not, no worries.

thanks,
Ben
