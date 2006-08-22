Return-Path: <donaldrussell@lucent.com>
Received: from hoemail2.lucent.com (hoemail2.lucent.com [192.11.226.163])
	by ozlabs.org (Postfix) with ESMTP id 973AD67B5B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Aug 2006 03:28:17 +1000 (EST)
Received: from mvcde.inse.lucent.com (h152-148-8-206.lucent.com
	[152.148.8.206])
	by hoemail2.lucent.com (8.13.6/IER-o) with ESMTP id k7MHL7b1004840
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Aug 2006 12:21:07 -0500 (CDT)
Message-ID: <44EB3D02.1010504@lucent.com>
Date: Tue, 22 Aug 2006 13:21:06 -0400
From: Don Russell <donaldrussell@lucent.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: linux 2.4.33 build question
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,
Id like to build the  2.4.33 version of Linux for the ads8272 board but
I get an error that says I must use an older  gcc version . 

The error comes from init/main.c and rejects anything greater than 3.  
The readme says to use the 2.95 compiler.

I downloaded the ELDK 3.0 and it failed also.  (Its actually 3.1)  There 
doesn't seem to be a 2.95 distro in the ELDK.   So naturally I tried 
taking out the version check and of course it failed elswhere in the build.

 If gcc 2.95  is truly required for building 2.4 , where can I get the 
toolchain, or do I have to build it ?

Does this linux version (2.4) also require an older u-boot?
Thanks
