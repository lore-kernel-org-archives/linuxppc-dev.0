Return-Path: <blofeldus@yahoo.com>
Received: from web53506.mail.yahoo.com (web53506.mail.yahoo.com
	[206.190.37.67]) by ozlabs.org (Postfix) with SMTP id 5F59B2BDEB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Nov 2004 09:42:49 +1100 (EST)
Message-ID: <20041123224241.1791.qmail@web53506.mail.yahoo.com>
Date: Tue, 23 Nov 2004 14:42:41 -0800 (PST)
From: roger blofeld <blofeldus@yahoo.com>
To: tnt@246tNt.com
In-Reply-To: <20041116201654.GA3088@xyzzy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Lite5200 FEC Driver on linux 2.6 (updated)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Sylvain,
 Using your latest tree still shows the packet checksum errors, despite
XLB snooping being enabled. I think that the cache flush is required or
that the skb pages must be marked coherent somehow. I note that the 8xx
fec.c file also has a cache flush, so it isn't that strange.
-rb


		
__________________________________ 
Do you Yahoo!? 
Meet the all-new My Yahoo! - Try it today! 
http://my.yahoo.com 
 
