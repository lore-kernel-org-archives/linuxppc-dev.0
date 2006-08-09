Return-Path: <johnnyb@eskimo.com>
Received: from ultra7.eskimo.com (ultra7.eskimo.com [204.122.16.70])
	by ozlabs.org (Postfix) with ESMTP id 1033367BE8
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Aug 2006 23:15:09 +1000 (EST)
Received: from eskimo.com (johnnyb@eskimo.com [204.122.16.13])
	by ultra7.eskimo.com (8.13.6/8.13.4) with ESMTP id k79DF45r003698
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Aug 2006 06:15:05 -0700
Date: Wed, 9 Aug 2006 06:15:06 -0700 (PDT)
From: Jonathan Bartlett <johnnyb@eskimo.com>
To: linuxppc-dev@ozlabs.org
Subject: .tc entries question
In-Reply-To: <20060725140634.GH6872@bubble.grove.modra.org>
Message-ID: <Pine.SUN.4.58.0608090611460.14141@eskimo.com>
References: <Pine.SUN.4.58.0607232059070.699@eskimo.com>
	<20060725021558.GG6872@bubble.grove.modra.org>
	<Pine.SUN.4.58.0607250612510.14690@eskimo.com>
	<20060725140634.GH6872@bubble.grove.modra.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Another 64-bit Elf question, this one about the TOC.  In many examples,
for defining toc entries, there is some syntax like this:

name_to_refer_to_this:
.tc seemingly_unused_name[TC], data_here

I haven't figured out what the purpose of the name immediately preceding
[TC] is.  In fact, it seems that in most cases it can simply be left out.
Is this just a holdover from a previous binary format, or does
"seemingly_unused_name" actually get used in some fashion?

Thanks,

Jon
