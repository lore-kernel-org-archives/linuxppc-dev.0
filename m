Return-Path: <ktdann@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.194])
	by ozlabs.org (Postfix) with ESMTP id CED5467B39
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Apr 2005 18:38:04 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 57so1438937wri
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Apr 2005 01:38:01 -0700 (PDT)
Message-ID: <9b7ca6570504120138738b554f@mail.gmail.com>
Date: Tue, 12 Apr 2005 17:38:01 +0900
From: Daniel Ann <ktdann@gmail.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: Trying to understand alloc_skb()
Reply-To: Daniel Ann <ktdann@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hiya folks,

I'm wondering if anyone could help me out with problem I have in alloc_skb().

My problem is that, kernel dies with "alloc_skb called nonatomically
from interrupt c00ba718" message. After browsing mailing list, I think
its to do with not providing it with enough locks prior.

Question is, what kind of lock should I be providing ?

Since I have no clue as to which lock does what, I really need some
good advise as to where to start looking.

Could someone tell me the inside story on this ?

-- 
Daniel
