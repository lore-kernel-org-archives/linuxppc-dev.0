Date: Thu, 17 Jun 2004 11:19:54 +0200
Message-Id: <HZG4L6$A14A0723F533A1C86A3AF192DB6EF298@scarlet.be>
Subject: Re: [PATCH] PPC601 MQ handling
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: "Stef Simoens" <stef.simoens@pi.be>
To: "benh" <benh@kernel.crashing.org>
Cc: "linuxppc-dev" <linuxppc-dev@lists.linuxppc.org>,
	"paulus" <paulus@samba.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Did you check it was actually saved/restored by the signal code ?
>
> Ben.

I looked up when XER gets saved/restored to save/restore MQ.

I tested my patch with
mqtest &
(start other programs which are 'MQ-enabled')
fg
^Z
...
and mqtest gave me the correct output.

I used the same principle to patch my 2.4 kernel and I'm running with the patch for over 3 months now.

If this isn't the answer you wanted, could you please point out what I should be testing?

Thanks

Stef


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
