Message-ID: <3F29280D.5020600@imc-berlin.de>
Date: Thu, 31 Jul 2003 16:30:37 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: large file support?
References: <20030731125013.64881C602D@atlas.denx.de> <3F2912C3.6060204@imc-berlin.de>
In-Reply-To: <3F2912C3.6060204@imc-berlin.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I wrote:

> And I just got these lines:
>
> Fillod Stephane wrote:
>  > Recent kernel and glibc are fine.
>  >
>  > Pass O_LARGEFILE to the second open() arg, and compile
>  > with "-D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64" should do it.
>
> and rebuilt my application. But the test (with my app) will take a
> while...

Now I the app is still running although the file is > 2GB. I get

~ # ls -l /mnt/intern/HDD_STRESS/2003-07-31\ 1*
/mnt/intern/HDD_STRESS/2003-07-31 14-54-57 (1):
ls: /mnt/intern/HDD_STRESS/2003-07-31 14-54-57 (1)/V001_G0.raw: Value
too large for defined data type
-rw-r--r--    1 root     root    1080356864 Jul 31 16:25 K001_G0.raw
-rw-r--r--    1 root     root    1080356864 Jul 31 16:25 K002_G0.raw

I guess I have to rebuild busybox with LFS as well...

Thanks to you all!

Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
