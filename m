Return-Path: <rpjday@mindspring.com>
Received: from mailhost.rdmcorp.com (world.rdmcorp.com [204.225.180.10])
	by ozlabs.org (Postfix) with ESMTP id D265767A89
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 27 Mar 2005 03:34:31 +1000 (EST)
Received: from [10.1.1.102] (10.1.2.1) by mailhost.rdmcorp.com (Worldmail
	1.3.167) for linuxppc-embedded@ozlabs.org; 26 Mar 2005 12:34:29 -0500
Date: Sat, 26 Mar 2005 12:32:54 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
In-Reply-To: <Pine.LNX.4.61.0503260953100.12378@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0503261231370.29477@localhost.localdomain>
References: <Pine.LNX.4.61.0503260953100.12378@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: 2.6.11-5 kernel on 8xx -- perhaps i messed up the console port?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Solved.

On Sat, 26 Mar 2005, Robert P. J. Day wrote:

... snip ...

>   has anything changed in the last little while in terms of the
> console port?  i tried to reproduce faithfully my earlier config
> options for console port support, but no luck.

rather than "console=ttyS0" as i used to use, it's now
"console=ttyCPM0".  and we're off ...

rday
