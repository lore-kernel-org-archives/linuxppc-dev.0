Message-ID: <20040813082211.34144.qmail@web15610.mail.cnb.yahoo.com>
Date: Fri, 13 Aug 2004 16:22:11 +0800 (CST)
From: Song Sam <samlinuxppc@yahoo.com.cn>
Subject: Re: JTAG debug mechanism
To: Li Yang-r58472 <LeoLi@freescale.com>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <01139FC052A0D411900B00508B9535FC0F0D2864@ZCH07EXM04.corp.mot.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Li Yang-r58472 <LeoLi@freescale.com> wrote:

> As we know PowerPC use JTAG to debug CPU, which

But 8xx use BDM to debug CPU.So I wonder in which
situation or chips should we use BDM and JATG and
WHY??? For a embedded developer,he could more concern
about this point than JATG implementation process,I
guess.:-)

> implements a Boundary-Scan mechanism. It can manipulate any
> input/output signals of the CPU by a serial shift/scan process. But my
> question is how it can read/write the core registers and system memory
> as implemented by most JTAG emulators.

Any input is warmly welcome!

Best regards,

Sam

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
