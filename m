Message-ID: <3FE339A1.6030100@embeddededge.com>
Date: Fri, 19 Dec 2003 12:47:13 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Kiran Mandava <kiran.mandava@skystream.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ep8260 board linux port
References: <DBF73ACB70D3D711A358000BDBACF5CE09D23B@SSMAIL1>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kiran Mandava wrote:

>   I am trying to port linux 2.4.22 onto ep8260 board. (256 MB RAM on 6xx
> bus/ 32 MB Flash) using tools and source code from denx webisite.
>   I was able to port u-boot and trying to boot linux now.
>   i couldn't find any specific files to this board in the platform directory
> although est8260.h file has the basic bd structure.


Oh crap.....another one I need to update.  I have all of the patches
that work with the EP boot rom.  You may have to update the Makefiles
to generate the proper u-boot image.

I'll try to get them in there sometime this weekend.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
