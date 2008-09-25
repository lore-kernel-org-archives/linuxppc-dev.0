Return-Path: <Bruce_Leonard@selinc.com>
In-Reply-To: <OF871A5E9F.D762FCD5-ON882574CF.005EDA9D-882574CF.005F1AE2@selinc.com>
To: Bruce_Leonard@selinc.com
Subject: Re: How do I access nvRAM from user space?
MIME-Version: 1.0
Message-ID: <OF8BD7431D.472FC678-ON882574CF.006401B8-882574CF.00642232@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Thu, 25 Sep 2008 11:13:43 -0700
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-embedded-bounces+brucle=selinc.com@ozlabs.org,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> 
> Thanks for the reply.  So if my nvSRAM device is located at 0xb0000000 
in 
> physical memory, what would the mmap() call look like?  Also, do I need 
to 
> have a device tree entry for the kernel to know about the memory?  I can 

> access the device in uboot so I know it works, but I can't figure out 
the 
> mmap to get it from linux
> 

Never mind.  I figured out how to use mmap.  It's all in the parameter 
'off' not 'addr' :).  Thanks to everyone who responded with help.

Bruce
