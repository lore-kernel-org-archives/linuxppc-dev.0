Return-Path: <wd@denx.de>
To: Oliver Rutsch <orutsch@sympatec.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: MPC5200 I2C and 2.6 kernel
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 27 Nov 2007 11:07:11 +0100."
	<474BEC4F.3080800@sympatec.com>
Date: Wed, 28 Nov 2007 21:22:45 +0100
Sender: wd@denx.de
Message-Id: <20071128202245.90051247C1@gemini.denx.de>
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <474BEC4F.3080800@sympatec.com> you wrote:
> 
> Regardless what I'm doing in the 2.6 kernel configuration I can't get 
> this RTC running (I activated RTC support and the driver for the M41T00 
> in the configuration).
> hwclock --debug tells me:

> hwclock: Open of /dev/rtc failed, errno=19: No such device.

Well... did you check how your /dev/rtc is set up? It used  to  be  a
misc  device with MAJ=10 MIN=135 in old kernel versions, but now it's
MAJ=254 MIN=4, i. e. it should look like this:

crw-r--r-- 1 root root 254,   0 Jun 22 18:30 /dev/rtc


Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
For every complex problem, there is a solution that is simple,  neat,
and wrong.                                           -- H. L. Mencken
