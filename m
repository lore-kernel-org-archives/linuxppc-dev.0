Message-ID: <3BD718AF.75934CD8@mvista.com>
Date: Wed, 24 Oct 2001 15:38:23 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: =?iso-8859-1?Q?K=E1ri=20Dav=ED=F0sson?= <kd@flaga.is>
Cc: "Linux Embedded ppc (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: microcodepatch
References: <EADB10BAC266A14A85ECBF8686A73E3145934F@kolkrabbi.flaga.is>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kári Davíðsson wrote:

> Are there any known issues regarding the I2C patch and the ethernet
> driver?

You need to ensure the patch is suitable for the CPM on the processor
you have.  I know the USB SOF patch works on the 823/850 Rev. B processors,
but I don't remember where the others came from.  You should probably
visit Motorola's web site and get the patch specific to your processor
and update the microcode patch file.

> If I disable the microcode patch everything works fine, except the I2C
> stuff.

Depending upon the application, sometimes it is easier and faster to
simply use the software toggle agorithm on the pins rather than the
CPM controller.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
