Date: Thu, 29 Jun 2000 10:01:25 -0700 (PDT)
From: Ani Joshi <ajoshi@shell.unixbox.com>
To: ian reinhart geiser <geiseri@msoe.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: XFree86 4.0 Support?
In-Reply-To: <Pine.OSF.3.96.1000629112916.12958A-100000@torres.msoe.edu>
Message-ID: <Pine.LNX.4.10.10006290957250.32735-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


No, the rpms in ~howarth will not work.  You will need to grab my latest
driver at devel.linuxppc.org/users/ajoshi/xf4.  The driver requires atyfb
(mode switching), source is also availble there too.

I suggest grabbing and building xfree86 cvs source and then installing the
binary driver.


ani

On Thu, 29 Jun 2000, ian reinhart geiser wrote:

> 	Can anyone tell me if the XFee86 Build on Entropy.crashing.org
> 	will work with an ATI Mach64?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
