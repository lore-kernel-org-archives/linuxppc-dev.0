Return-Path: <rpjday@mindspring.com>
Received: from tomts22-srv.bellnexxia.net (tomts22.bellnexxia.net
	[209.226.175.184]) by ozlabs.org (Postfix) with ESMTP id E8FDC2BDB4
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Oct 2004 09:16:54 +1000 (EST)
Date: Fri, 8 Oct 2004 19:10:01 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20041008223243.7D84CC1430@atlas.denx.de>
Message-ID: <Pine.LNX.4.60.0410081908410.3331@localhost.localdomain>
References: <20041008223243.7D84CC1430@atlas.denx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: next pass of cleaning up micropatch.c 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sat, 9 Oct 2004, Wolfgang Denk wrote:

> In message <Pine.LNX.4.60.0410081643100.25430@dell.enoriver.com> you wrote:
>>
>> nice idea, but sadly, doomed to failure.  note that the code to copy
>> the patch arrays *requires* you to be able to take the sizeof() those
>> arrays to know *exactly* how much to copy.  if you pass the array to a
>> function by its address, i'm pretty sure you lose the ability to take
>> its sizeof() anymore, isn't that right?
>
> This is not right. Guess how memcpy() works - it's a function, btw.

sure.  and it accepts a size parameter, which is why it works.  i'm 
not sure what you're getting at.

rday
