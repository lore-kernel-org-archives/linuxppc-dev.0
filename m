Message-ID: <4022576C.8030808@kegel.com>
Date: Thu, 05 Feb 2004 06:47:08 -0800
From: Dan Kegel <dank@kegel.com>
MIME-Version: 1.0
To: Jaap-Jan Boor <jjboor@aimsys.nl>
Cc: Thamarai Selvan <Thamarai.Selvan@lntinfotech.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Error encountered when make of gcc-3.3.2
References: <OF4C3019EA.ACB29788-ON65256E31.0024D5FB@lntinfotech.com> <1075971443.8546.5.camel@linpc003.aimsys.nl>
In-Reply-To: <1075971443.8546.5.camel@linpc003.aimsys.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jaap-Jan Boor wrote:
> Thamarai,
>
> you need some patches to cross build gcc 3.x, but better
> use crosstool, it includes the patches needed, both
> for the compiler and glibc, and a script to build and
> install everything.
>
> http://www.kegel.com/crosstool/

Aw, shucks, thanks for the plug!

(For the curious, the patch Jaap-Jan attached is documented
at http://penguinppc.org/embedded/cross-compiling/ and isn't
included in crosstool simply because crosstool includes glibc headers.)

- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
