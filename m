Message-ID: <004401c43e07$df9e8e60$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "Zajac Adam-AAZ004" <Adam.Zajac@motorola.com>,
	<linuxppc-embedded@lists.linuxppc.org>
References: <EFB813091B18D511BD3600508B644F820A617EF3@tx14exm06.ftw.mot.com>
Subject: Re: Summary: Question on the fs choice (long)
Date: Wed, 19 May 2004 21:14:57 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Regarding the hardware protection of flash chips on power-down:  There's a
circuit we used to use to protect battery-backed RAM from this problem.  The
basic technique is to hold the CS high when the power falls below a certain
value.  See maxim-ic.com for chips that do this.  I think for flash
substituting a capacitor for the battery would implement a similar function.

Just an idea, I don't know if anyone's actually tried it with flash...

Mark Chambers

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
