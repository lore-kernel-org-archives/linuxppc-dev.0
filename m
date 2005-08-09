Return-Path: <clemens.koller@anagramm.de>
Received: from moutvdomng.kundenserver.de (moutvdom.kundenserver.de
	[212.227.126.249]) by ozlabs.org (Postfix) with ESMTP id B635767FD0
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 Aug 2005 23:31:51 +1000 (EST)
Message-ID: <42F8B043.5050804@anagramm.de>
Date: Tue, 09 Aug 2005 15:31:47 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: JohnsonCheng <johnsoncheng@qnap.com.tw>
References: <0MKrQq-1E2Rl01y8u-0004mW@mxeu12.kundenserver.de>
In-Reply-To: <0MKrQq-1E2Rl01y8u-0004mW@mxeu12.kundenserver.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: A configure error for samba3 on ppc
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, JohnsonCheng!

you wrote:
> Yes. But how can I pass the testing?

Running it on the target - where it is actually supposed to work.

> For cross-compile environment, the HOST and the TARGET are almost not the
> same, so many utility can configure for cross-compile with host setting
> except samba.

Well, you can tell configure to skip the tests silently if HOST!=TARGET
or give the message you got. But I wouldn't expect configure to guess
how it can get the code from the host to the target.
Yes, it's indeed a bad virus ;-)

> It seems not sense.

I'd like to see the message.
For me I prefer to compile things native - if somehow possible.

Greets,

Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19

> -----Original Message-----
> From: Clemens Koller [mailto:clemens.koller@anagramm.de] 
> Sent: Tuesday, August 09, 2005 6:24 PM
> To: JohnsonCheng
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: A configure error for samba3 on ppc
> 
> Hi, JohnsonCheng!
> 
> you wrote:
> 
>>When I configure samba3.0.10 on ppc as following command:
>>
>>CC=powerpc-linux-gcc AR=powerpc-linux-ar RANLIB=powerpc-linux-ranlib
>>./configure -host=powerpc-linux
>>
>>I got a configure error message as following:
>>Configure: error: cannot run test program while cross compiling
>>See 'config.log' for more details
>>
>>I think this is a samba configure bug, do anybody know how to pass it?
> 
> 
> No, it's not a bug. It's exactly what the message trys to tell you.
> Samba wants to do some tests. But as it's not a native build,
> it doesn't want to execute itself for the tests. Because
> samba might not run on a different platform as it was built for.
> 
> If you want to do the tests, you need to let to do it on the
> target where it was built for and not where it was built on.
> 
> Samba works fine over here on ppc embedded systems.
> 
> Greets,
> 
> Clemens Koller
