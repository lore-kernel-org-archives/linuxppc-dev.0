Date: Tue, 2 Dec 2003 01:26:40 +0100
Subject: Re: 2.6 PReP issues, still freezing
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v553)
Cc: linuxppc-dev@lists.linuxppc.org
To: Christian Kujau <evil@g-house.de>
From: Remco Post <r.post@sara.nl>
In-Reply-To: <3FCBCC0A.5060107@g-house.de>
Message-Id: <3314B262-245E-11D8-A10A-000393911DE2@sara.nl>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tuesday, Dec 2, 2003, at 00:17 Europe/Amsterdam, Christian Kujau
wrote:
>
> so you really have a de2104x card. and your problems differ from mine,
> as i never got any Oopses.
>
> did you try Jeff Garzik's fixes for this driver?
>
> http://marc.theaimsgroup.com/?l=linux-kernel&m=106950312306991&w=2
>


I did just know... oops....

> they were for some -test9-bk tree, but neither the -test10 nor the
> -test11 ChangeLog says something about the fixes, so i think they are
> still pending.
>
>> CONFIG_PPC_CHRP=y
>> CONFIG_PPC_PMAC=y
>> CONFIG_PPC_PREP=y
>> CONFIG_PPC_OF=y
>
> how many archs do you want to boot at once? :-)
>


you know... cp ../<oldkernel>/.config .; yes "" | make oldconfig; make

I don't really notice my config... And it doesn't really matter. I'll
trim it down a bit, just to be sure....

>
> Thanks,
> Christian.
> --
> BOFH excuse #233:
>
> TCP/IP UDP alarm threshold is set too low.
>
>
>
>
--
Met vriendelijke groeten,

Remco Post

SARA - Reken- en Netwerkdiensten                      http://www.sara.nl
High Performance Computing  Tel. +31 20 592 8008    Fax. +31 20 668 3167

"I really didn't foresee the Internet. But then, neither did the
computer
industry. Not that that tells us very much of course - the computer
industry
didn't even foresee that the century was going to end." -- Douglas Adams


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
