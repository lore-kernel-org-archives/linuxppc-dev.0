To: Sebastien Articlaux <sebastien_articlaux@yahoo.com>
Cc: embedded linuxppc <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: nm command
References: <20000216155509.19793.qmail@web217.mail.yahoo.com>
From: Jesper Skov <jskov@redhat.com>
Date: 16 Feb 2000 17:55:19 +0100
In-Reply-To: Sebastien Articlaux's message of "Wed, 16 Feb 2000 07:55:09 -0800 (PST)"
Message-ID: <otg0utnl3c.fsf@thinktwice.zoftcorp.dk>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>>>>> "Sebastien" == Sebastien Articlaux <sebastien_articlaux@yahoo.com> writes:

Sebastien> Hello,

Sebastien> I've tried this command (and a lot of others like this...)
Sebastien> to get symbol table but without success...

It's automatically generated. See System.map

Sebastien>    nm vmlinux | sort | less

-> file format not recognize

Sebastien> what is the format of vmlinux?  Thanks.

Try powerpc-unknown-linux-gnu-nm.

Jesper

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
