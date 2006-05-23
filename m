Return-Path: <anton@ozlabs.org>
Date: Wed, 24 May 2006 01:15:41 +1000
From: Anton Blanchard <anton@samba.org>
To: jfaslist <jfaslist@yahoo.fr>
Subject: Re: Maple: killing a  process that causes a machine check exception
Message-ID: <20060523151541.GB10468@krispykreme>
References: <44732357.4000506@yahoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <44732357.4000506@yahoo.fr>
Cc: linuxppc64-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> By  applying the following mods (plse see below), i was able to have a 
> user process that caused a machine check exception to be terminated (on 
> a Maple platform), as expected. I was wondering why the PPC64 had a 
> different ME handling than PPC which does send the SIGBUS to the process?

Not all machine checks are synchronous so we cant always do this. From
memory the ppc64 version will panic if the machine check wasnt
synchronous.

Anton
