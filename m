Message-ID: <3C04A483.6070206@humboldt.co.uk>
Date: Wed, 28 Nov 2001 08:46:59 +0000
From: Adrian Cox <adrian@humboldt.co.uk>
MIME-Version: 1.0
To: paulus@samba.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: include/asm-ppc/platforms/
References: <15363.31192.101536.919771@gargle.gargle.HOWL>	<3C2B376F.9070508@embeddededge.com> <15364.32906.728532.676746@gargle.gargle.HOWL>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:

> The patch below does all this.  It does mean that we will need a
> platform header for every platform, and a platform_serial header for
> every platform where we want to use the standard serial driver.  As an
> example, I have made an all_ppc_serial.h that contains most of what
> was in serial.h before.  In fact, with a bit of care we could make
> serial.h be the symlink.


All my boards now use early_serial_setup() instead of a platform header
file. This approach is simple to write, and requires no modifications
outside the platform_setup.c file. I'd rather not go back to providing
platform specific serial definitions in a header file.

--
Adrian Cox   http://www.humboldt.co.uk/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
