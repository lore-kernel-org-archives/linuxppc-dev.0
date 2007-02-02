Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 92A7ADDDF6
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Feb 2007 18:30:20 +1100 (EST)
To: Daniel Ng <daniel_ng11@lycos.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: ELDK glibc fcntl(socketFd,
	=?utf-8?b?Rl9TRVRGTCw=?= flags) causes Seg Fault
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 01 Feb 2007 06:56:43 GMT."
	<loom.20070201T073939-302@post.gmane.org>
Date: Fri, 02 Feb 2007 08:30:18 +0100
Sender: wd@denx.de
Message-Id: <20070202073018.C8710352B86@atlas.denx.de>
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

In message <loom.20070201T073939-302@post.gmane.org> you wrote:
> 
> My application Seg Faults when I try to set flags for my socket fd.
> 
> First, I get the fd by calling socket():
> fd = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);
> 
> Then I try getting the fd flags:
> fcntl(fd, F_GETFL, flags)

Provide some working / crashing test code, i. e. a complete C program
with declarations etc.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
There's an old story about the person who wished his computer were as
easy to use as his telephone. That wish has come  true,  since  I  no
longer know how to use my telephone.
