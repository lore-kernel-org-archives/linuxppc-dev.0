From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Samuel Rydh <samuel@ibrium.se>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 640x480 on iBook/Titanium
Date: Mon, 9 Jul 2001 23:21:29 +0200
Message-Id: <20010709212129.7627@smtp.wanadoo.fr>
In-Reply-To: <20010709224810.A1931@ibrium.se>
References: <20010709224810.A1931@ibrium.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Does anybody know how to the fb.modes configuration for 640x480
>on the iBook and/or on the titanium? I would like to bundle these
>mode lines with MOL.

Well, changing the display size on those would require some
hacking with the flat panel scaler, which I think aty128fb
is not yet able to do.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
