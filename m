Date: Tue, 6 Apr 2004 08:21:35 +0200
From: Marc Leeman <marc.leeman@barco.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCI Memory mapping
Message-ID: <20040406062135.GD30819@smtp.barco.com>
Reply-To: Marc Leeman <marc.leeman@barco.com>
References: <20040324110814.E50148@forte.austin.ibm.com> <20040325154845.GF3696@smtp.barco.com> <20040325103414.C64292@forte.austin.ibm.com> <20040325104529.D64292@forte.austin.ibm.com> <20040326080012.GA7238@smtp.barco.com> <1080676178.7581.30.camel@localhost.localdomain> <20040331155625.GB28919@smtp.barco.com> <20040401123340.GA6085@smtp.barco.com> <20040402140130.GG22365@smtp.barco.com> <1081175362.20952.30.camel@localhost.localdomain>
Mime-Version: 1.0
In-Reply-To: <1081175362.20952.30.camel@localhost.localdomain>
Content-Type: text/plain; charset=iso-8859-15
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I know I've been flooding the mailing list with this particular little
topic and thanks to some valuable comments [1], we were able to
pinpoint our problem fairly quickly.

Partly based on a number of related known silicon bugs, I have drafted
the following description (and work-around) that explains our data
corruption.

http://scorpius.homelinux.org/~marc/masterwrite/

[1] There is still one comment which is in the queue to be investigated.

 marc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
