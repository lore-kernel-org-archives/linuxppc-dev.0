From: Paul Mackerras <paulus@linuxcare.com>
To: linuxppc-dev@lists.linuxppc.org, Martin Costabel <costabel@wanadoo.fr>
Subject: Re: 2.3.43 failed
Date: Tue, 15 Feb 2000 10:20:21 +1100
Content-Type: text/plain
References: <38A7C1DF.99A5346@wanadoo.fr>
MIME-Version: 1.0
Message-Id: <00021510205202.09337@argo.linuxcare.com.au>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 14 Feb 2000, Martin Costabel wrote:

> Thanks. Your new version in 2.3.45pre works correctly (shows me once
> more why I'm not a kernel developer: I replaced all 3 occurrences of
> dev_kfree_skb by if (in_irq()) ... else ..., which worked, too; you
> replaced just one of them by dev_kfree_skb_irq; I had tried this before,
> but always got the wrong one :-( ).

Actually, I can't take the credit, the fix was in the official 2.3.45-pre2.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
