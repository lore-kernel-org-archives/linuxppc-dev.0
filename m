Message-ID: <3804499E.291265F@arcormail.de>
Date: Wed, 13 Oct 1999 09:58:07 +0100
From: Michael Fenske <michael.fenske@arcormail.de>
Reply-To: michael.fenske@arcormail.de
MIME-Version: 1.0
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Problem with glibc-2.1.3-0a.src.rpm ?
References: <3803A7BC.4175E431@arcormail.de> <99101300580600.00880@ns1102.munich.netsurf.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Franz Sirl wrote:
> 
> Did you install all parts of gcc-2.95.1? cpp is easily forgotten. What output
> do you get from 'egcs -v' and 'gcc -v'?

I have installed the following parts:

  cpp-2.95.1-0a
  gcc-2.95.1-0a
  gcc-c++-2.95.1-0a
  gcc-objc-2.95.1-0a

egcs -v returns

  bash: egcs: command not found  // what a surprise ;-)

gcc -v returns

  Reading specs from /usr/lib/gcc-lib/ppc-redhat-linux/2.95.1/specs
  gcc version 2.95.1 19990809 (prerelease)

Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
