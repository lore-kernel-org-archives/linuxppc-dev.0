Return-Path: <mathieu.deschamps@com2gether.net>
Received: from mail.libertysurf.net (mx-out.libertysurf.net [213.36.80.91])
	by ozlabs.org (Postfix) with ESMTP id F1C2767A3A
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Jul 2006 18:59:21 +1000 (EST)
From: Mathieu Deschamps <mathieu.deschamps@com2gether.net>
To: bwarren@qstreams.com
Subject: Re: JFFS2 FS is read-only (not what I want)
Date: Tue, 4 Jul 2006 10:59:44 +0200
References: <44A6E57A.3080302@qstreams.com>
	<1151955491.12449.32.camel@saruman.qstreams.net>
	<1151957564.12449.39.camel@saruman.qstreams.net>
In-Reply-To: <1151957564.12449.39.camel@saruman.qstreams.net>
MIME-Version: 1.0
Message-Id: <200607041056.47824.mathieu.deschamps@com2gether.net>
Content-Type: text/plain;
  charset="utf-8"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Monday 03 July 2006 22:12, Ben Warren wrote:
>  On Mon, 2006-07-03 at 15:38 -0400, Ben Warren wrote:
> > This is starting to look to me like a generation-time issue.  I built
> > another JFFS2 partition out of a random directory on my workstation, and
> > it's behaving properly:
>
> Sorry for filling people's inboxes, but it turns out the problem was
> between the chair and keyboard.  

arf ! computer hardly ever suffer this problem :)

>My JFFS2 partition was slightly less
> than 2MB, which I guess decompresses to > 2 MB, filling up the
> partition.  I must have been in the wrong directory when issuing the
> 'du' command.  On the plus side, I've learned quite a bit about MTD and
> JFFS2 going through this exercise!
>
> regards,
> Ben


Regards,
mathdesc



-------
I guess this illustrate a difference between knowledge and 
understanding. The first without second is confusion, the second without
first is a miss.
