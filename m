Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 1E39A67C96
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Jul 2005 16:30:32 +1000 (EST)
From: David Jander <david.jander@protonic.nl>
To: Wolfgang Denk <wd@denx.de>
Date: Wed, 20 Jul 2005 08:30:26 +0200
References: <20050719183745.AD52A352671@atlas.denx.de>
In-Reply-To: <20050719183745.AD52A352671@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200507200830.27141.david.jander@protonic.nl>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: How reliable is jffs2 really (denx cvs devel kernel)?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tuesday 19 July 2005 20:37, you wrote:
>[...]
> You probably want to ask this on the MTD mailing list;  don't  forget
> to  mention  the  exact  version of the MTD / JFFS2 code you're using
> (see CVS history).

I already thought it might be a good idea to subscribe to that list.
Any hint about how I can figure out exactly which version of MTD code I have?
The version of linuxppc_2_4_devel I have is about 2 months old, do I have to 
expect important changes concerning MTD since then?

While we are there, what other solution would you suggest for this problem: We 
need to log data into flash. Right now I use an oversized jffs2 partition, 
log via syslogd and logrotate on size. I am getting the impression that this 
is not workable for mission critical things. At least not with the kernel and 
MTD code I have. Others must have the same problem, so here's my question: 
Which way to do such a thing? Write my own filesystem?

Greetings,

-- 
David Jander
