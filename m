Date: Tue, 22 Jun 2004 13:50:19 +0200
From: Marc Leeman <marc.leeman@barco.com>
To: bharat <bharat@coraltele.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: shared libraries
Message-ID: <20040622115019.GK10248@smtp.barco.com>
Reply-To: Marc Leeman <marc.leeman@barco.com>
References: <1087563278.19489.3156.camel@hades.cambridge.redhat.com> <205EB944-C12D-11D8-ACD7-000393DBC2E8@freescale.com> <1087827285.18627.66.camel@hades.cambridge.redhat.com> <20040621232921.GD8561@smtp.west.cox.net> <18376179.1087898789671.JavaMail.administrator@RnDserver> <8563787.1087903962281.JavaMail.administrator@RnDserver>
Mime-Version: 1.0
In-Reply-To: <8563787.1087903962281.JavaMail.administrator@RnDserver>
Content-Type: text/plain; charset=iso-8859-15
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> in hardhat linux i am not getting hoe can i make shared libraries make
> available as i am nfs mounting /target folder and shared libraries are
> in /powerpc-hardhat-linux folder .

Just like any other GNU/Linux system: compile them for the correct
architecture and install them relative to /root/dir/target

I would think that /root/dir/target contains all the vendor supplied
libraries.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
