Message-ID: <3CB470A1.20206@embeddededge.com>
Date: Wed, 10 Apr 2002 13:04:33 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Jean-Denis Boyer <jdboyer@mediatrix.com>
Cc: "'Ricardo Scop'" <scop@vanet.com.br>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8260 - Spurious interrupt when calling __sti()
References: <F1BED55F35F4D3118C0F00E0295CFF4DFF9F93@mail.mediatrix.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jean-Denis Boyer wrote:

> At the left of the comment is 'SYNC', in uppercase.

That's correct.  This macro is empty for the 8260.
This is needed for those processors that don't properly 'isync'
the mtmsr instruction, which is usually engineering sample silicon
or the 601.

	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
