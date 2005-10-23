Return-Path: <SRS0+294551be047bdcc6b225+791+infradead.org+dwmw2@baythorne.srs.infradead.org>
Received: from baythorne.infradead.org (baythorne.infradead.org [81.187.2.161])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CDDD36856A
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 23 Oct 2005 21:38:32 +1000 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: Nathael PAJANI <nathael.pajani@cpe.fr>
In-Reply-To: <1129621982.3830.310.camel@baythorne.infradead.org>
References: <43539813.8010809@cpe.fr>
	<1129621982.3830.310.camel@baythorne.infradead.org>
Content-Type: text/plain
Date: Sun, 23 Oct 2005 12:38:26 +0100
Message-Id: <1130067506.6932.23.camel@baythorne.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Newbie... in mailing lists...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 2005-10-18 at 08:53 +0100, David Woodhouse wrote:
> That's a problem with the archives; it's not your fault. If you look
> at the mailto: link at the top of that page, you see it looks like
> this:
> 
> mailto:linuxppc-embedded%40ozlabs.org?Subject=eldk%203.1.1%20ramdisk%20image%20problem&In-Reply-To=
> 
> Although it _attempts_ to set the In-Reply-To: header which would make
> your message appear to be a reply to the mail in the archive, it seems
> to be missing the actual message-id of that mail; it's just empty.

I filed this mailman bug along with a partial fix at
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=171567

-- 
dwmw2
