Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 31CBDDDE99
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Jan 2008 19:36:08 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1JAi2A-0008Ae-55
	for linuxppc-embedded@ozlabs.org; Fri, 04 Jan 2008 00:36:06 -0800
Message-ID: <14612555.post@talk.nabble.com>
Date: Fri, 4 Jan 2008 00:36:06 -0800 (PST)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Reading a config file in a driver ....
In-Reply-To: <20080103163019.GA4223@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <14591717.post@talk.nabble.com> <20080103163019.GA4223@lixom.net>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Could you please let me know How in the driver i could be able to read the
file present in sysfs ??? Using init script how should i creat and edit the
file ????

I never had done these hence your suggession could be a better way for me to
learn it .

---Misbah


Olof Johansson-2 wrote:
> 
> On Wed, Jan 02, 2008 at 09:03:20PM -0800, Misbah khan wrote:
>> 
>> Hi all ....
>> 
>> I am writing a LCD driver in which the default configuration for LCD
>> would
>> be loded at the Init . This default configuration if keep in the driver
>> then
>> for a change in default configuration we need to compile the driver which
>> we
>> never want . Hence we want a .config file in /etc/lcd.config dir which
>> could
>> be changed and the next boot will take this configuration as the default
>> configuration. 
>> 
>> I need to know How to read from the config file in the driver form the
>> dir
>> /etc/lcd.config. The driver would be installed at boot up 
> 
> The driver/kernel shouldn't read the file directly, if anything you
> should have a userspace tool that reads it and adjusts the driver via
> sysfs or similar. That tool can be run from some of the init scripts,
> or from the ramdisk in case you want to do it early.
> 
> 
> -Olof
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
View this message in context: http://www.nabble.com/Reading-a-config-file-in-a-driver-....-tp14591717p14612555.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
