In-Reply-To: <DBF73ACB70D3D711A358000BDBACF5CE09D23B@SSMAIL1>
References: <DBF73ACB70D3D711A358000BDBACF5CE09D23B@SSMAIL1>
Mime-Version: 1.0 (Apple Message framework v606)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <26FE0593-323D-11D8-BA5A-000A95B312BA@onz.com>
Cc: linuxppc-embedded@lists.linuxppc.org
From: Allen Curtis <acurtis@onz.com>
Subject: Re: ep8260 board linux port
Date: Fri, 19 Dec 2003 08:05:23 -0800
To: Kiran Mandava <kiran.mandava@skystream.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>   I am trying to port linux 2.4.22 onto ep8260 board. (256 MB RAM on
> 6xx
> bus/ 32 MB Flash) using tools and source code from denx webisite.
>   I was able to port u-boot and trying to boot linux now.
>   i couldn't find any specific files to this board in the platform
> directory
> although est8260.h file has the basic bd structure. the problem i am
> facing
> is the processor loops in serial_console_write/ timer interrupt
> handler. i
> made sure that i am passing the baudrate proeprly by looking at the bd
> structure while passing teh control to start_kernel function.
>

How are you creating your boot image. If you are following the u-boot
directions then you don't need any board specific support in the
kernel. If you are trying to boot zImage, then you have more work to
do.

>   My console does display everything properly running u-boot but once
> the
> control goes to linux don't see anything on the console.
>

Did you happen to customize the BAUD rate information for u-boot or
Linux?  The u-boot default is 115K, Linux default is 9600.

Another thing that I have run into is the clock divider configuration
by u-boot. Try changing your minicom baud rate up or down by 4X and see
if you see anything then.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
