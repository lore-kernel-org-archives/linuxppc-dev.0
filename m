Return-Path: <blofeldus@yahoo.com>
Received: from web53504.mail.yahoo.com (web53504.mail.yahoo.com
	[206.190.37.65]) by ozlabs.org (Postfix) with SMTP id 662472BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Nov 2004 08:23:23 +1100 (EST)
Message-ID: <20041118202213.20094.qmail@web53504.mail.yahoo.com>
Date: Thu, 18 Nov 2004 12:22:13 -0800 (PST)
From: roger blofeld <blofeldus@yahoo.com>
To: Dale Farnsworth <dale@farnsworth.org>
In-Reply-To: <20041116201654.GA3088@xyzzy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tnt@246tNt.com, linuxppc-embedded@ozlabs.org
Subject: Re: Lite5200 FEC Driver on linux 2.6 broken? (fixed again)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Adding a call 

    flush_dcache_range((u32)skb->data, (u32)skb->data + skb->len);

 just before spin_lock_irq() in fec_hard_start_xmit() removes the
remaining transmission checksum errors for me.
-rb


		
__________________________________ 
Do you Yahoo!? 
Meet the all-new My Yahoo! - Try it today! 
http://my.yahoo.com 
 
