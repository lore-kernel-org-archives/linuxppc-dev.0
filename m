Return-Path: <wd@denx.de>
To: zhangwei zhang <linda.zhangwei@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: about uImage-DENX-v2.6.14 config
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 15 Nov 2007 07:13:27 +0100."
	<200711150713.28211.sr@denx.de>
Date: Sun, 18 Nov 2007 01:43:01 +0100
Sender: wd@denx.de
Message-Id: <20071118004301.475BC247F1@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <200711150713.28211.sr@denx.de> Stefan Roese wrote:
> On Wednesday 14 November 2007, zhangwei zhang wrote:
> > Hello, I have a problem when using linux-2.6.14(download from
> > ftp.denx.de) for RTAI on ppc440EP.
> 
> RTAI on PPC? I thought RTAI was dead for anything other than X86.

Stefan is right.

RTAI is dead.

You should use Xenomai instead.

> And 2.6.14 is quite old. I suggest you use a newer binary version or compile a 
> the image from the current kernel source.

He is reight again. Pleas euse a current kernel version from our git
repository; Xenomai should support this directly.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
1 1 was a race-horse, 2 2 was 1 2. When 1 1 1 1 race, 2 2 1 1 2.
