Date: Fri, 6 Sep 2002 10:39:08 -0700
From: Matt Porter <porter@cox.net>
To: Aman <aman@mistralsoftware.com>
Cc: Matt Porter <porter@cox.net>,
	linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: ELDK Compiler
Message-ID: <20020906103908.A30038@home.com>
References: <000f01c24d3e$4fed5460$370da8c0@aman> <20020826135747.A10250@home.com> <003001c255c7$a246ff90$370da8c0@aman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <003001c255c7$a246ff90$370da8c0@aman>; from aman@mistralsoftware.com on Fri, Sep 06, 2002 at 10:35:42PM +0530
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Sep 06, 2002 at 10:35:42PM +0530, Aman wrote:
> I  have downloaded ELDK compiler for PPC 440 evalkit. In the ELDK html file
> , it says the the predefined compiler flag as "mcpu=403". Will this ELDK
> compiler work very well with PPC 440 processor?. Or are there any other
> compilers which works well with PPC 440 processor.

Nobody has provided PPC440-specific support for binutils.  Right now,
everybody is using mcpu=[403|405] since they define an identical
set of instructions. The -mbooke support in current binutils will
not work on 440 since it is e500 specific.

The ELDK toolchain works fine.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
