Message-ID: <380F1A0F.5E06@idecnet.com>
Date: Thu, 21 Oct 1999 15:50:07 +0200
From: Epicom <epicom@idecnet.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: glibc........ memory limitations.... ideas?
References: <OFFBA23814.6BE68D05-ON00256810.0052B029@flaga.is>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


kd@flaga.is wrote:
> 
> Hi,
> 
> I have a small question...
> 
> We are developing an embedded solution as most of the people here on the
> list. This means that we (or at least I) are limited be the amount of
> available memory in the units.
> We for example are limited by a 2 MB flash chip that might someday be 4MB.
> In maybe 1.2MB of this chip I can stuff applications that need to run on
> the device.
> A statically linked application (with glibc) is arround 300KB (250KB
> -450KB).  which means that I can stuff maybe 3-4 statically linked
> applications in the flash.
> 
> The othre option is to link the applications dinamically to glibc and
> stdlibc++. libc-2.1.1.so is around 4 MB and stdlibc++ is around 2.5 MB. So

Have you stripped them?, libc is only 1 Mb if you run strip in it.
It is still too big for 2Mb, but it can fit well in 4Mb of flash.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
