To: mpclinux <mpclinux@sina.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Does ELDK include SELF? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 20 May 2003 09:23:58 +0800."
             <20030520012358.5910.qmail@sina.com>
Date: Tue, 20 May 2003 08:22:09 +0200
Message-Id: <20030520062215.13848C6162@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

in message <20030520012358.5910.qmail@sina.com> you wrote:
>
>      I am a greenhand of LinuxPPC. Recently, I have installed ELDK2.0.2
> on my RedHat8.0 PC, and I want to build a Ramdisk with SELF, then I
> downloaded the SELF*.tar.gz from Wolfgang's ftpsite, but all of them

The SELF tarball on our FTP server is the "old" versio, which assumes
that you buile everything from  scratch,  i.  e.  from  the  pristine
source tarballs.

With the ELDK installed, all these tools (in one version or  another)
are  ready  available,  so  we  can  safe  the  effort of recompiling
everything.

> only contains PATCHes, I turned to ELDK2.0.2 and found that there are
> two RPMs they are:
> SELF-ppc_8xx-xxx.ppc.rpm
> busybox-ppc_8xx-xxx.yyy.ppc.rpm

Busybox is used to build the SELF RPM, but SELF is complete in itself.

> I think they will contain all source codes of SELF.

No. These RPMs contain the binary RPMs.

>     I typed ./install -d /opt/ELDK202 ppc_8xx to install ELDK, but I
> can not find other SELF-related files except for two pRamdisk files in
> opt/eldk202/images.

But these _are_ the SELF images.

>     I wonder what's is wrong with my ELDK installation? If no, how can I
> build pMulti/pImage/pRamdisk with SELF?

There is nothing wrong. Either you can use the  ramdisk  images  that
come  with  the distribution, or you can build your own by rebuilding
the  SELF  RPM.  See  the  instructions  for  recompilation  of  ELDK
packages.  You  can  check  out  the  build  environment from our CVS
server.

Hope this helps.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
WARNING:  This Product Warps Space and Time in Its Vicinity.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
