Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id DBD78DDDF8
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 24 Dec 2007 15:02:19 +1100 (EST)
Date: Sun, 23 Dec 2007 22:09:15 -0600
From: Olof Johansson <olof@lixom.net>
To: ramkumarj Ramkumar <ramkumarj2000@gmail.com>
Subject: Re: Loop at starting pid 164, tty '': '/sbin/getty'
Message-ID: <20071224040915.GA20380@lixom.net>
References: <4f8c3030712220051if731af9g350af9d45a75c244@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4f8c3030712220051if731af9g350af9d45a75c244@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

On Sat, Dec 22, 2007 at 04:51:16PM +0800, ramkumarj Ramkumar wrote:

> I m trying to run Linux 2.6 ( From Grant) on ML-403. I used the
> busybox-1.7.2. During booting, I found the following logs and it keeps
> trying to respawn the getty.It keeps looping and I never see the login
> prompt.  Am I missing something.
> 
> process '/sbin/getty 38400 tts/0' (pid 163) exited. Scheduling it for
> restart.

Do you have a /dev/ttys/0? First serial port is normally /dev/ttyS0.


-Olof
