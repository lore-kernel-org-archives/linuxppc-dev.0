Return-Path: <clemens.koller@anagramm.de>
Received: from moutvdomng.kundenserver.de (moutvdom.kundenserver.de
	[212.227.126.249]) by ozlabs.org (Postfix) with ESMTP id C53FE67EB2
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 Aug 2005 20:24:10 +1000 (EST)
Message-ID: <42F88445.4030001@anagramm.de>
Date: Tue, 09 Aug 2005 12:24:05 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: JohnsonCheng <johnsoncheng@qnap.com.tw>
References: <20050807091603.CE57667F29@ozlabs.org>
In-Reply-To: <20050807091603.CE57667F29@ozlabs.org>
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
> When I configure samba3.0.10 on ppc as following command:
> 
> CC=powerpc-linux-gcc AR=powerpc-linux-ar RANLIB=powerpc-linux-ranlib
> ./configure -host=powerpc-linux
> 
> I got a configure error message as following:
> Configure: error: cannot run test program while cross compiling
> See 'config.log' for more details
> 
> I think this is a samba configure bug, do anybody know how to pass it?

No, it's not a bug. It's exactly what the message trys to tell you.
Samba wants to do some tests. But as it's not a native build,
it doesn't want to execute itself for the tests. Because
samba might not run on a different platform as it was built for.

If you want to do the tests, you need to let to do it on the
target where it was built for and not where it was built on.

Samba works fine over here on ppc embedded systems.

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
