In-Reply-To: <1068793571.9828.40.camel@gaston>
References: <20031114011048.GG24030@gaast.net> <1068793571.9828.40.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v606)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3A608183-168E-11D8-917E-000393A7EF6C@gaast.net>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
From: Wilmer van der Gaast <wilmer@gaast.net>
Subject: Re: Oops in current linux-2.5-benh
Date: Fri, 14 Nov 2003 11:35:12 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 14-nov-03, at 8:06, Benjamin Herrenschmidt wrote:

> Does it happen if you built i2c in the kernel instead of as a module ?
>
Hmm. I thought I had I2C completely in the kernel already, but I see I
had i2c-keywest as a module. IIRC I need that one on PMAC?

I'll try again.

--
+-------- .''`.     - -- ---+  +        - -- --- ---- ----- ------+
| lintux : :'  :  lintux.cx |  | OSS Programmer   www.bitlbee.org |
|   at   `. `~'  debian.org |  | www.algoritme.nl   www.lintux.cx |
+--- -- -  ` ---------------+  +------ ----- ---- --- -- -        +


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
