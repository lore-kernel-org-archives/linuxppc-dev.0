Return-Path: <shiyuanqi@yahoo.com>
Received: from web54409.mail.yahoo.com (web54409.mail.yahoo.com
	[206.190.49.139]) by ozlabs.org (Postfix) with SMTP id 2AE0CDDEAB
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 09:07:37 +1000 (EST)
Date: Mon, 14 May 2007 16:00:56 -0700 (PDT)
From: Shiyuan Qi <shiyuanqi@yahoo.com>
Subject: network fail at linux2.6.10
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <900235.77064.qm@web54409.mail.yahoo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


I am using linux2.6.10 and coldfire 5475 and have seen
the problem of "KERNEL: assertion
(!skb_queue_empty(&sk->sk_write_queue))"
failure various times.
 I saw a fix for 2.6.9 in the
http://www.linuxarkivet.se/mlists/linux-net/0410/msg00195.html

But in 
http://ozlabs.org/pipermail/linuxppc-dev/2005-January/018336.html
you mentioned "Yes these are known problems which
should be fixed in 2.6.10.  However,
there is at least one other similar issue in 2.6.10 so
you'll either
want to stay with 2.6.6 or go up to the latest bk
snapshot."

Could anyone please tell me what is "the other similar
issue in 2.6.10"? I suspect this might be issue I got.

Thank you very much,



       
____________________________________________________________________________________Need a vacation? Get great deals
to amazing places on Yahoo! Travel.
http://travel.yahoo.com/
