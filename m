Return-Path: <rpjday@mindspring.com>
Received: from tomts25-srv.bellnexxia.net (tomts25.bellnexxia.net
	[209.226.175.188]) by ozlabs.org (Postfix) with ESMTP id 4B2E12BDB4
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Oct 2004 10:00:17 +1000 (EST)
Date: Fri, 8 Oct 2004 19:53:22 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20041008235611.70B92C1430@atlas.denx.de>
Message-ID: <Pine.LNX.4.60.0410081953060.3838@localhost.localdomain>
References: <20041008235611.70B92C1430@atlas.denx.de>
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

> In message <Pine.LNX.4.60.0410081930510.3440@localhost.localdomain> you wrote:
>>
>> oh, sure, if you know the length, it's easy.  and who wants to count
>> those bytes?  not me.  that's why i long ago dropped the idea of
>> writing a function.
>
> You mean it is more difficult to use "sizeof(foo)" as a parameter  to
> a function than inside one of your macros?
>
> Wow. You see me surprised.

ok.  point taken.

rday
