From: benh@kernel.crashing.org
To: <msokolov@ivan.Harhan.ORG>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: EV-64260-BP & GT64260 bi_recs
Date: Wed, 27 Mar 2002 18:48:51 +0100
Message-Id: <20020327174851.14516@mailhost.mipsys.com>
In-Reply-To: <0203271732.AA04381@ivan.Harhan.ORG>
References: <0203271732.AA04381@ivan.Harhan.ORG>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>But why is the MAC address in ASCII? Why not simply put the 6 bytes in there?
>Why the extra burden of parsing the ASCII?

Well, I would put the 6 bytes, I beleive he wrote it to make it
readable for us ;)

The point of bi_recs is indeed to avoid ascii (to avoid wasting too
much space). Or else we would just use a device_tree or an xml
tree :)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
