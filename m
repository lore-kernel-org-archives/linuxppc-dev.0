Return-Path: <greg.weeks@timesys.com>
Received: from postfix.timesys.com (mail.timesys.com [65.117.135.102])
	by ozlabs.org (Postfix) with ESMTP id B05E9686FA
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Nov 2005 06:27:49 +1100 (EST)
Message-ID: <437493D3.2070301@timesys.com>
Date: Fri, 11 Nov 2005 07:51:31 -0500
From: Greg Weeks <greg.weeks@timesys.com>
MIME-Version: 1.0
To: lily <lichanjuan04@st.lzu.edu.cn>
References: <331697990.25627@st.lzu.edu.cn>
In-Reply-To: <331697990.25627@st.lzu.edu.cn>
Content-Type: text/plain; charset=GB2312
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: floating point operation of ppc
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

lily wrote:

> hi,all:
> i build an embedded linux on powerpc 405ep,i need execute floating
> point operation,and i enable "math emulate" option in kernel, i run a
> while(1)loop ,in the loop there was floating point expression ,after
> test ,i found the while (1) exit because of the floating point
> computation,that is the floating point can't execute on ppc
> stablely.Is there someone meets the same problems ,please give me some
> suggestion,thanks!!!

The 405ep has some errata on floating point use. I didn't work on the
processor so I don't know exactly what they are, but Timesys has a
toolchain just for the 405ep to work around the problem. The other
workaround we've used is much slower and it involved disabling the
hardware floating point unit in the head.s for the 405ep and turning on
the emulator. Just turning on the emulator is insufficient. The Timesys
toolchain isn't the only one out there specifically for the 405ep.

Greg Weeks
