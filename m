Return-Path: <wd@denx.de>
Received: from mailout03.sul.t-online.com (mailout03.sul.t-online.com
	[194.25.134.81]) by ozlabs.org (Postfix) with ESMTP id 70C8267F27
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 Aug 2005 17:58:42 +1000 (EST)
To: "FCG WANG Baohua" <Baohua.WANG@alcatel-sbell.com.cn>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 12 Aug 2005 14:03:08 +0800."
	<A9DE2BAF233E444FA9C5E77A5825A01E86505F@ydmail.sbell.com.cn>
Date: Fri, 12 Aug 2005 09:58:07 +0200
Sender: wd@denx.de
Message-Id: <20050812075807.E9613352B36@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: strange things about swap on NFS 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <A9DE2BAF233E444FA9C5E77A5825A01E86505F@ydmail.sbell.com.cn> you wrote:
> 
>   But I found that the "dd if=/dev/zero of=swapfile bs=1M
> count=62" is not easy to executed:

This command alone should just work fine.

>   The system is often no response after execute this command. On several
> time, it add swap successfully.
>    But  when I start to compile package. The system then no response !!

>From your subject and this description I understand that you then try
to use this file as swapfile over NFS, and this causes problems.

There is a known problem with swap over NFS, at least for 2.4 kernels.

>    How to slove the problem? Is the reason of my hard disk? I think not,

RTFM. A solution is described in detail at
http://www.denx.de/twiki/bin/view/DULG/SwappingOverNFS

Note that this is terribly slow, though - but sometimes  it's  better
to  have  a slow and working system than one which is fast and out of
memory.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
You can't evaluate a man by logic alone.
	-- McCoy, "I, Mudd", stardate 4513.3
