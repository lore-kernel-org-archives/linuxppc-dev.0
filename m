MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: http sharing in linux
Date: Mon, 17 May 2004 15:03:13 +0200
Message-ID: <FD6CA6C74666E546981AEBE7F147C5121CE8B5@mx-dk1.dk.vitesse.com>
From: "Holger L. Bille" <hlb@vitesse.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > > recommend me some opensource solutions?
> >
> > solution=(embedded)?boa:apache;
>
> Ummm... depending on requirements, Mbedthis AppWeb, GoAhead,  khttpd,
> and others come to mind, too.

I recommend to _not_ use goahead! It is 100% broken in its handling of binary CGI posts. It cost me many hours to realize this. I was working at file uploads at the time.

Instead I highly recommend thttpd - a very solid product!
http://www.acme.com/software/thttpd/
133531 bytes without tweaking

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
