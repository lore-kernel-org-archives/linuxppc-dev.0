Date: Fri, 02 Apr 2004 17:09:55 -0500
From: Jeff Tucker <jeff@jltnet.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Need help booting linux on IBM 405EP eval board
Message-ID: <18366018.1080925795@[192.168.0.230]>
In-Reply-To: <20040402185107.B77E5C109F@atlas.denx.de>
References: <20040402185107.B77E5C109F@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--On Friday, April 02, 2004 8:51 PM +0200 Wolfgang Denk <wd@denx.de> wrote:

>
> In message <1866383.1080909296@[192.168.0.230]> you wrote:
>>
>> I sent a message like this to the U-Boot mailing list last night. I've
>> been
>
> And you have received replies thaty pointed to the problem.
>

Indeed, as my later email indicated, I found that the Linux build is using
the file arch/ppc/platforms/evb405ep.[c/h] and that file has a board_info
struct, separate and different from the ppcboot.h file which is in a
totally different directory. I've made evb405ep.h match U-Boot's u-boot.h,
but that hasn't helped my problem.

I guess I have two questions then:
- Does the build environment (from ELDK 3.0) for the 405EP evaluation board
use the file mentioned above? Is that the place where I have to make the
board_info struct match the struct in U-Boot
(u-boot/include/asm-ppc/u-boot.h)?

- Has the Linux/build environment already been ported for this particular
board? It's in the Makefile and there are certainly board-specific files
available in the above directory. So, I figured that I wouldn't have to go
through a porting process to boot Linux. And, again, the IBM bootloader
loads and boots kernels just fine.

Does anyone out there use this evaluation board, Linux 2.4 and U-Boot or am
I really the first?

Thanks
Jeff

--
Jeff Tucker
jeff@jltnet.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
