From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <tom_gall@vnet.ibm.com>, <linuxppc-dev@lists.linuxppc.org>,
	Paul Mackerras <paulus@samba.org>
Subject: Re: CONFIG_ALL_PPC
Date: Wed, 28 Nov 2001 23:19:28 +0100
Message-Id: <20011128221928.8366@smtp.wanadoo.fr>
In-Reply-To: <3C0561FE.80489F5E@vnet.ibm.com>
References: <3C0561FE.80489F5E@vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Hmmm well not that I object because I don't... but I am working on this POP
>board here and technically speaking it's the next in the great PREP / PMAC /
>CHRP chain...
>
>CONFIG_PREP_PMAC_CHRP_POP?  ICK!
>
>I'm hopeful in the end it'll fall into the CHRP catagory but some of these
>firmware differences could be a bear to resolve. But I might be a little
>over-alarmist too...

It's a difficult choice ;)

What about CONFIG_COMMON_PPC ? Still a bit misleading, but probably
better than CONFIG_ALL_PPC...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
