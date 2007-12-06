Return-Path: <bwarren@qstreams.com>
Received: from smtp102.biz.mail.re2.yahoo.com (smtp102.biz.mail.re2.yahoo.com
	[68.142.229.216]) by ozlabs.org (Postfix) with SMTP id 6F79ADE03C
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Dec 2007 06:55:56 +1100 (EST)
Message-ID: <475853CA.7070906@qstreams.com>
Date: Thu, 06 Dec 2007 14:55:54 -0500
From: Ben Warren <bwarren@qstreams.com>
MIME-Version: 1.0
To: khollan <khollan@daktronics.com>
Subject: Re: Uboot and ML410
References: <14177109.post@talk.nabble.com>	<00b501c83782$0f1241b0$2d36c510$@com>
	<14198812.post@talk.nabble.com>
In-Reply-To: <14198812.post@talk.nabble.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

khollan wrote:
>
> John Hahn wrote:
>   
>> We are also using 3.81 make (Centos 5 distro) with ELDK 4.1 version
>> downloaded from www.denx.de and have had no problems using the u-boot.zip
>> srcs from www.xilinx.com/ml410_p, though we use uboot for our ml403 based
>> development, we can build u-boot for ml403_config as well as ml410_config.
>>
>>
>> Cheers
>>
>> John
>>
>>     
>
> When I try compiling with my tools I get the message 
>  No rule to make target `hello_world.srec', needed by `all'
> Any way to work around this.  I have compiled everything else I use on my
> system with these tools and it works fine.  I did some research on this
> problem and it seemed to be a problem with the newer versions of make, but
> if thats not the case what is the problem?  I don't really want to install
> ELDK to keep things consistent.
> Thanks
> Kevin
>   
This is an old problem that has been fixed in the U-boot make files for 
probably a year or so. If you can't upgrade U-boot, just comment out the 
'examples' line in U-boot's main Makefile like this:

SUBDIRS = tools \
# examples

regards,
Ben
