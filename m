Message-ID: <40048A4B.1040400@g-house.de>
Date: Wed, 14 Jan 2004 01:16:11 +0100
From: Christian <evil@g-house.de>
MIME-Version: 1.0
To: "Matthew S. McClintock" <mattsm@arlut.utexas.edu>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: cpu_setup_6xx.S:19:22: ppc_defs.h: No such file or directory
References: <1074025766.23751.2.camel@chuck.arlut.utexas.edu>
In-Reply-To: <1074025766.23751.2.camel@chuck.arlut.utexas.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Matthew S. McClintock wrote:
| I have a problem with the kernel build. It seems completely random in
| occurrence, however I'm sure something has to be causing it.The error is
| as follows:
|
| cpu_setup_6xx.S:19:22: ppc_defs.h: No such file or directory
|
| And the kernel build can not complete. Sometimes running a make dep and
| continuing again with a make uImage will correct the problem but not
| always. Does anyone have any idea why sometimes this file does not get
| built correctly and other times it does?

filesystem / memory corruption, even slightly overclocking the cpu, too
old / too new compiler or binutils.
when the error occurs, can you actually stat ppc_defs.h ?

Christian.
- --
BOFH excuse #200:

The monitor needs another box of pixels.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
