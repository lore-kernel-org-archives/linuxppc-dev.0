Return-Path: <rpjday@mindspring.com>
Received: from tomts10-srv.bellnexxia.net (tomts10.bellnexxia.net
	[209.226.175.54]) by ozlabs.org (Postfix) with ESMTP id D10602BDB4
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Oct 2004 09:40:07 +1000 (EST)
Date: Fri, 8 Oct 2004 19:33:09 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20041008232920.C68C6C1430@atlas.denx.de>
Message-ID: <Pine.LNX.4.60.0410081930510.3440@localhost.localdomain>
References: <20041008232920.C68C6C1430@atlas.denx.de>
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

> I'm surprised that you didn't think about the possibility to pass the
> patch length as an argument to the function, that's all.  This  seems
> all  too  obvious  to  me.

oh, sure, if you know the length, it's easy.  and who wants to count 
those bytes?  not me.  that's why i long ago dropped the idea of 
writing a function.

personally, i still like the macro solution.  it seems to be 
appropriate for a 2-line loop, but i'm not going to start that
discussion again.  time to move on.

rday
