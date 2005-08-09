Return-Path: <johnsoncheng@qnap.com.tw>
Received: from qnap.com.tw (unknown [211.75.85.25])
	by ozlabs.org (Postfix) with SMTP id CFF4B67FB3
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 Aug 2005 20:54:52 +1000 (EST)
From: "JohnsonCheng" <johnsoncheng@qnap.com.tw>
To: "'Clemens Koller'" <clemens.koller@anagramm.de>
Date: Tue, 9 Aug 2005 18:54:15 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <42F88445.4030001@anagramm.de>
Message-Id: <20050809105452.CFF4B67FB3@ozlabs.org>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: A configure error for samba3 on ppc
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Yes. But how can I pass the testing?
For cross-compile environment, the HOST and the TARGET are almost not the
same, so many utility can configure for cross-compile with host setting
except samba.
It seems not sense.

Thanks,
Johnson Cheng

-----Original Message-----
From: Clemens Koller [mailto:clemens.koller@anagramm.de] 
Sent: Tuesday, August 09, 2005 6:24 PM
To: JohnsonCheng
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: A configure error for samba3 on ppc

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
