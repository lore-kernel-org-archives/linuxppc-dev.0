Subject: Re: Pegasos 2 support patch ...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040629204230.GA15900@pegasos>
References: <20040629165029.GA13468@pegasos>
	 <20040629204230.GA15900@pegasos>
Content-Type: text/plain
Message-Id: <1088564249.1906.14.camel@gaston>
Mime-Version: 1.0
Date: Tue, 29 Jun 2004 21:57:29 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Another solution would be to test before doing the translate call, maybe
> this would be more elegant ?

Yup, if you know it will be broken, don't bother calling it,
and please, avoid the over-long line :)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
