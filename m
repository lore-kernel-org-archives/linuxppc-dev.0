Message-ID: <3F2912C3.6060204@imc-berlin.de>
Date: Thu, 31 Jul 2003 14:59:47 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: large file support?
References: <20030731125013.64881C602D@atlas.denx.de>
In-Reply-To: <20030731125013.64881C602D@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:

> In message <3F290506.3060304@imc-berlin.de> you wrote:
>
>>I reckon my app does not support large files. Since after writing 2GB
>>to a file
>
>
> Did  you  build  it  with  the  required  options,   like   #defining
> _FILE_OFFSET_BITS as 64 ?

Nope!
But good point! :o)
And I just got these lines:

Fillod Stephane wrote:
 > Recent kernel and glibc are fine.
 >
 > Pass O_LARGEFILE to the second open() arg, and compile
 > with "-D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64" should do it.

and rebuilt my application. But the test (with my app) will take a
while...

Thanks!

Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
