From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <linuxppc-dev@lists.linuxppc.org>,
	Stefan Jeglinski <jeglin@4pi.com>
Subject: Re: ethtool failure with tulip 21143
Date: Thu, 27 Dec 2001 16:22:11 +0100
Message-Id: <20011227152211.3321@smtp.noos.fr>
In-Reply-To: <p04330100b8504e9e9393@[66.57.250.32]>
References: <p04330100b8504e9e9393@[66.57.250.32]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I remember even further contacting Donald Becker about somehow
>inserting this cache alignment fix into the tulip driver. No
>response. So, any thoughts on how to proceed? I have no idea how to
>get the fix into tulip to test...
>

I'll try to hack you something in tulip to test.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
