Message-ID: <3CB3FCBB.40608@cambridgebroadband.com>
Date: Wed, 10 Apr 2002 09:50:03 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
MIME-Version: 1.0
To: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: question concerning ram filestructure
References: <D73A25AA6E54D511AD74009027B1110F0F3151@ORION>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Are you using mkimage to build a ppcboot-compatible ramdisk?  If not then have a look at SELF on
denx's FTP site for an example of how to build make one.

Alex

Steven Blakeslee wrote:

> I'm working with linux 2.4 on an embedded planet ep405.  I have been trying
> to get a ram file structure working but I'm getting a reoccuring error.
>
> RAMDISK: Compressed image found at block 0
> crc errorFreeing initrd memory: 2201k freed
> Kernel panic: VFS: Unable to mount root fs on 01:00
> <0>Rebooting in 180 seconds..
>
> I've seen this before on different ports of linux but I have not been able
> to figure it out.  Does anyone have suggestions?
> Steven Blakeslee
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
